
ns pickchat.component.core
  :require
    [] reagent.core :as r
    [] pickchat.component.welcome-page :refer
      [] welcome-page
    [] pickchat.component.module :refer
      [] vspace hspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

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
      let
          user-id $ get-in store $ [] :state :user-id
        [] :div ({} :style la/fullscreen)
          if (string? user-id)
            [] work-page send
            [] welcome-page send
