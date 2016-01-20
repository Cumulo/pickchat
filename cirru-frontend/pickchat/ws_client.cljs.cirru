
ns pickchat.ws-client
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] reagent.core :as r
    [] cljs.reader :as reader
    [] cljs.core.async :as a :refer
      [] >! <! chan

defonce send-chan $ chan
defonce receive-chan $ chan

def ws $ new js/WebSocket |ws://localhost:4005

enable-console-print!
set! (.-onopen ws) $ fn ()
  println "|socket opened"

set! (.-onmessage ws) $ fn (event)
  let
      changes $ reader/read-string (.-data event)
    go
      >! receive-chan changes

go $ loop ([])
  .send ws $ pr-str (<! send-chan)
  recur
