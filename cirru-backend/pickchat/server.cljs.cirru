
ns pickchat.server
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema
    [] pickchat.ws-server :as ws-server
    [] pickchat.expand :refer
      [] expand
    [] pickchat.updater.core :refer
      [] updater
    [] cljs.core.async :as a :refer
      [] >! <! chan
    [] differ.core :as differ

nodejs/enable-util-print!
defn -main ()
  println "|server started"
set! *main-cli-fn* -main

defonce data-center $ atom schema/database

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
        new-store $ expand new-data state-id
        old-store $ or (get @client-caches state-id) ({})
        changes $ differ/diff old-store new-store
      println "|∆=client" state-id changes
      >! ws-server/send-chan $ {} :target state-id :changes changes
      swap! client-caches assoc state-id new-store
  reset! data-center new-data
  recur
