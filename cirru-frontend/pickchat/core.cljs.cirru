
ns pickchat.core
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] reagent.core :as r
    [] pickchat.ws-client :as ws-client
    [] pickchat.component.core :as component
    [] differ.core :as differ
    [] devtools.core :as devtools

enable-console-print!

devtools/set-pref! :install-sanity-hints true
devtools/install!

defonce data-center $ r/atom $ {}

defn send (action-type action-data)
  println action-type action-data
  go
    >! ws-client/send-chan $ {} :type action-type :data action-data

defn mountit ()
  r/render-component
    [] component/page @data-center send
    .querySelector js/document |#app

mountit

go $ loop ([])
  let
      changes $ <! ws-client/receive-chan
    reset! data-center $ differ/patch @data-center changes
    .info js/console "|∆" changes
    mountit
    recur
