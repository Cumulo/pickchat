
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
    [] pickchat.component.message :refer
      [] message-box message-list
    [] cljs.core.async :as a :refer
      [] >! <! chan
  :require-macros
    [] cljs.core.async.macros :refer
      [] go

defn channel-list (channels send)
  [] :div ({} :style la/column)
    ->> channels
      map last
      sort $ fn (chan-a chan-b)
        cond
          (< (:time chan-a) (:time chan-b)) 1
          (> (:time chan-a) (:time chan-b)) -1
          :else 0
      map $ fn (channel)
        let
            switch-channel $ fn (event)
              send :channel/enter (:id channel)
          [] :div ({} :style wi/channel :key (:id channel) :on-click switch-channel) (:title channel)

defn work-page (store send)
  let
      check-profile $ fn (event)
        send :modal/add $ {} :name :profile :type :modal
      create-channel $ fn (event)
        send :modal/add $ {} :name :create-channel :type :modal
      go-home $ fn (event)
        send :channel/leave
    fn (store send)
      let
          channels $ :channels store
          channel-id $ get-in store $ [] :state :channel-id
          user $ :user store
          dirty-chan $ chan
        [] :div ({} :style la/app)
          [] :div ({} :style la/sidebar)
            [] :div ({} :style la/sidebar-header)
              [] :div ({} :style wi/entry-icon :on-click go-home) |Home
              hspace 10
              [] :div ({} :style wi/entry-icon :on-click create-channel) |＋
            hr
            [] :div ({} :style la/sidebar-body)
              channel-list (:channels store) send
          vr
          [] :div ({} :style la/body)
            [] :div ({} :style la/body-header)
              if (some? channel-id)
                [] :div ({} :style la/header-title) (get-in channels $ [] channel-id :title)
                [] :div ({} :style la/header-title) "|No channel selected"
              [] :div ({} :style la/header-cornor :on-click check-profile)
                [] :div ({} :style (wi/main-avatar (:avatar user)))
            hr
            [] :div ({} :style la/body-body :id :scroll)
              message-list (:seen-messages store) store dirty-chan send
            hr
            if (some? channel-id)
              [] :div ({} :style la/body-footer)
                [] message-box dirty-chan send

defn page (store send)
  let
      draft $ r/atom |
      on-draft-change $ fn (event)
        reset! draft (-> event .-target .-value)
    fn (store send)
      let
          user-id $ get-in store $ [] :state :user-id
        [] :div ({} :style la/fullscreen)
          if (string? user-id)
            [] work-page store send
            [] welcome-page send
          [] notifications (get-in store $ [] :state :notifications) send
          [] modal-stack (get-in store $ [] :state :modals) store send
