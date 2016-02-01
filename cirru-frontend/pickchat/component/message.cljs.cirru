
ns pickchat.component.message
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.module :refer
      [] vspace hspace
    [] pickchat.component.member :refer
      [] member-avatar
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

defn message-item (message member user-id send)
  let
      like-message $ fn (event)
        send :message/like (:id message)
      likes $ count (:liked-by message)
      liked-by-me? $ some
        fn (member-id) (= member-id user-id)
        :liked-by message
    [] :div ({} :style wi/message :key (:id message))
      member-avatar member :normal send
      hspace 10
      [] :div ({} :style wi/message-detail)
        [] :div ({} :style wi/message-time) (format/display-time (:time message))
        [] :div ({})
          :text message
          hspace 20
          [] :div ({} :style wi/heart-block :on-click like-message)
            [] :span ({} :style (wi/heart-symbol liked-by-me?)) |❤
            if (> likes 0)
              [] :span ({} :style wi/heart-count) likes

defn message-list (messages store dirty-chan send)
  [] :div ({} :style la/message-list)
    ->> messages
      map $ fn (message)
        let
            author-id $ :author-id message
            member $ get-in store $ [] :users author-id
          message-item message member (get-in store ([] :user :id)) send
