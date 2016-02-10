
ns pickchat.component.core
  :require
    [] reagent.core :as r
    [] pickchat.component.welcome-page :refer
      [] welcome-page
    [] pickchat.component.module :refer
      [] vspace hspace hr vr
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.notifications :refer
      [] notifications
    [] pickchat.component.modal :refer
      [] modal-stack
    [] pickchat.component.workspace :refer
      [] work-page
    [] pickchat.component.edn-viewer :refer
      [] edn-viewer
    [] cljs.core.async :as a :refer
      [] >! <! chan
  :require-macros
    [] cljs.core.async.macros :refer
      [] go

defn page (store send)
  let
      draft $ r/atom |
      show-edn $ r/atom true
      on-draft-change $ fn (event)
        reset! draft (-> event .-target .-value)
      toggle-edn $ fn (event)
        reset! show-edn $ not @show-edn
      on-key-down $ fn (event)
        if
          and
            .-shiftKey event
            .-metaKey event
            = (.-key event) |a
          toggle-edn event
        , nil

    fn (store send)
      let
          user-id $ get-in store $ [] :state :user-id
        [] :div ({} :style la/fullscreen :tab-index 0 :on-key-down on-key-down)
          if (string? user-id)
            [] work-page store send
            [] welcome-page send
          [] notifications (get-in store $ [] :state :notifications) send
          [] modal-stack (get-in store $ [] :state :modals) store send
          if @show-edn
            [] edn-viewer store send
