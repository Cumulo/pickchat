
ns pickchat.component.message
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.module :refer
      [] vspace hspace

defn message-box ()
  let
      text $ r/atom |
      on-change $ fn (event)
        reset! text (-> event .-target .-value)
    fn (send)
      let
          on-key-down $ fn (event)
            if (= (.-keyCode event) 13)
              do
                send :message/create @text
                .preventDefault event
                reset! text |
        [] :textarea $ {} :style wi/message-box :placeholder "|Say something"
          , :value @text :on-change on-change :on-key-down on-key-down

defn message-item (message user send)
  [] :div ({} :style wi/message :key (:id message))
    [] :div ({} :style (wi/message-avatar (:avatar user)))
    hspace 10
    [] :div ({}) (:text message)

defn message-list (messages store send)
  [] :div ({} :style la/message-list)
    ->> messages
      map $ fn (message)
        let
            author-id $ :author-id message
            user $ get-in store $ [] :users author-id
          message-item message user send
