
ns pickchat.component.message
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.module :refer
      [] vspace hspace
    [] cljs.core.async :as a :refer
      [] >! <! chan
    [] pickchat.util.format :as format
  :require-macros
    [] cljs.core.async.macros :refer
      [] go

defn message-box (dirty-chan send)
  let
      text $ r/atom |
      on-change $ fn (event)
        reset! text (-> event .-target .-value)
    fn (dirty-chan send)
      let
          on-key-down $ fn (event)
            if (= (.-keyCode event) 13)
              if (> (count @text) 0)
                do
                  send :message/create @text
                  .preventDefault event
                  reset! text |
                do
                  .preventDefault event
                  let
                      target $ .querySelector js/document "|#scroll"
                    set! (.-scrollTop target)
                      - (.-scrollHeight target) 400 60
        [] :textarea $ {} :style wi/message-box :placeholder "|Say something"
          , :value @text :on-change on-change :on-key-down on-key-down

defn message-item (message user send)
  [] :div ({} :style wi/message :key (:id message))
    [] :div ({} :style (wi/message-avatar (:avatar user)))
    hspace 10
    [] :div ({} :style wi/message-detail)
      [] :div ({} :style wi/message-time) (format/display-time (:time message))
      [] :div ({}) (:text message)

defn message-list (messages store dirty-chan send)
  [] :div ({} :style la/message-list)
    ->> messages
      map $ fn (message)
        let
            author-id $ :author-id message
            user $ get-in store $ [] :users author-id
          message-item message user send
