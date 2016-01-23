
ns pickchat.ws-server
  :require-macros
    [] cljs.core.async.macros :refer
      [] go
  :require
    [] cljs.nodejs :as nodejs
    [] cljs.core.async :as a :refer
      [] >! <! chan
    [] cljs.reader :as reader

defonce receive-chan $ chan
defonce send-chan $ chan
defonce socket-registry $ atom $ {}

def shortid $ js/require |shortid
def ws $ js/require |ws
def WebSocketServer (.-Server ws)
def wss $ new WebSocketServer (js-obj |port 4005)

.on wss |connection $ fn (socket)
  let
      state-id $ .generate shortid
      now $ new js/Date
    go
      >! receive-chan $ {}
        :type :state/connect
        :data nil
        :meta $ {} :time (.valueOf now) :id (.generate shortid) :state-id state-id
    swap! socket-registry assoc state-id socket
    .on socket |message $ fn (rawData)
      let
          now $ new js/Date
          action $ reader/read-string rawData
        go
          >! receive-chan $ {}
            :type (:type action)
            :data (:data action)
            :meta $ {} :time (.valueOf now) :id (.generate shortid) :state-id state-id
    .on socket |close $ fn ()
      let
          now $ new js/Date
        swap! socket-registry dissoc state-id
        go
          >! receive-chan $ {}
            :type :state/disconnect
            :data nil
            :meta $ {} :state-id state-id :time (.valueOf now) :id (.generate shortid)

go $ loop ([]) $ let
    msg-pack $ <! send-chan
    socket $ get @socket-registry (:target msg-pack)
  .send socket $ pr-str (:changes msg-pack)
  recur
