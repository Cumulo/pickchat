
ns pickchat.server
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema
    [] pickchat.ws-server :as ws-server
    [] pickchat.viewer :refer
      [] framing
    [] pickchat.scene :refer
      [] erect
    [] pickchat.updater.core :refer
      [] updater
    [] cljs.core.async :as a :refer
      [] >! <! chan
    [] differ.core :as differ
    [] cljs.reader :as reader

nodejs/enable-util-print!

def fs $ js/require |fs
def db-filename |target/db.edn

defonce data-center $ atom $ if (.existsSync fs db-filename)
  let
      old-db $ reader/read-string $ .readFileSync fs db-filename |utf8
    assoc old-db :states ({})
  , schema/database

defonce client-caches $ atom $ {}

go $ loop ([]) $ let
    msg (<! ws-server/receive-chan)
    new-data $ updater @data-center (:type msg) (:data msg) (:meta msg)
  println "|-->" (:type msg) (:data msg)
  println "|∆=db" $ differ/diff @data-center new-data
  doseq
    [] state-entry (:states new-data)
    let
        state-id $ first state-entry
        scene $ erect new-data
        new-store $ framing scene state-id new-data
        old-store $ or (get @client-caches state-id) ({})
        changes $ differ/diff old-store new-store
      if
        not= changes ([] ({}) ({}))
        do
          println "|∆=client" state-id changes
          >! ws-server/send-chan $ {} :target state-id :changes changes
          swap! client-caches assoc state-id new-store
  reset! data-center new-data
  recur

defn -main ()
  js/setInterval
    fn ()
      .writeFileSync fs db-filename (pr-str @data-center)
      println "|wrote to target/db.edn"
    , 20000
  println "|server started"

set! *main-cli-fn* -main
