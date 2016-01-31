
ns pickchat.component.channel
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] imput hspace vspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn render-create-channel (modal-data store send)
  let
      text $ r/atom |
      on-change $ fn (event)
        reset! text $ -> event (.-target) (.-value)
      submit $ fn (event)
        send :channel/create @text
        send :modal/remove-one (:id modal-data)
    fn (modal-data store send)
      [] :div ({} :style la/form)
        [] :div ({} :style la/form-line)
          [] :div ({} :style la/form-field) |Topic
          [] :input $ {} :style wi/form-textbox :on-change on-change :value @text :placeholder |Topic
        [] :div ({} :style la/action-bar)
          [] :div ({} :style wi/button :on-click submit) |Submit
