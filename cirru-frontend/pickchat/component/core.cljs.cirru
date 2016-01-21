
ns pickchat.component.core
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn task (task)

defn hspace (x)
  [] :div
    {} :style
      merge la/hspace $ {} :width x

defn vspace (x)
  [] :div
    {} :style
      merge la/vspace $ {} :height x

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
        [] :textarea $ {} :style wi/message-box :placeholder "|Say something" :value @text :on-change on-change :on-key-down on-key-down

defn work-page ()
  fn (send)
    [] :div ({} :style la/app)
      [] :div ({} :style la/sidebar)
        [] :div ({} :style la/sidebar-header)
        [] :div ({} :style la/sidebar-body)
      [] :div ({} :style la/body)
        [] :div ({} :style la/body-header)
        [] :div ({} :style la/body-body)
        [] :div ({} :style la/body-footer)
          [] message-box send

defn page ()
  let
      draft $ r/atom |
      on-draft-change $ fn (event)
        reset! draft (-> event .-target .-value)
    fn (store send)
      println store
      let
          on-create $ fn (event)
            if (> (count @draft) 0)
              do
                send :task/create @draft
                reset! draft |
        [] :div ({} :style la/fullscreen)
          [] work-page send
