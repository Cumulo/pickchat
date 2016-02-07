
ns pickchat.component.workspace
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] vspace hspace hr vr
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.message :refer
      [] message-box message-list message-collection
    [] pickchat.component.member :refer
      [] member-avatar
    [] cljs.core.async :as a :refer
      [] >! <! chan
  :require-macros
    [] cljs.core.async.macros :refer
      [] go

defn channel-list (channels grouped-users order send)
  [] :div ({} :style la/column)
    ->> channels
      map last
      sort $ fn (chan-a chan-b)
        if (= order :activity)
          cond
            (< (:last-message-time chan-a) (:last-message-time chan-b)) 1
            (> (:last-message-time chan-a) (:last-message-time chan-b)) -1
            :else 0
          cond
            (< (:time chan-a) (:time chan-b)) 1
            (> (:time chan-a) (:time chan-b)) -1
            :else 0
      map $ fn (channel)
        let
            switch-channel $ fn (event)
              send :channel/enter (:id channel)
            is-private $ :is-private channel
          [] :div
            {} :style (wi/channel is-private) :key (:id channel) :on-click switch-channel
            if (some? (:last-message channel))
              [] :div ({} :style wi/channel-update)
                member-avatar (:last-author channel) :small send
                hspace 10
                [] :span ({} :style wi/channel-update-content)
                  :text (:last-message channel)
            [] :div ({} :style wi/channel-info)
              [] :div ({} :style wi/channel-title) (:title channel)
              [] :div ({} :style wi/channel-members)
                ->> (get grouped-users (:id channel))
                  map $ fn (user)
                    member-avatar user :small send

defn work-page (store send)
  let
      check-profile $ fn (event)
        send :modal/add $ {} :name :profile :type :modal
      create-channel $ fn (event)
        send :modal/add $ {} :name :create-channel :type :modal
      go-home $ fn (event)
        send :channel/leave
      order $ r/atom :activity
      view-by-activity $ fn (event)
        reset! order :activity
      view-by-create-time $ fn (event)
        reset! order :create-time
    fn (store send)
      let
          channels $ :channels store
          channel-id $ get-in store $ [] :state :channel-id
          channel $ get-in channels $ [] channel-id
          user $ :user store
          dirty-chan $ chan
          collected-messages $ ->> (:seen-messages store)
            filter $ fn (message)
              or
                > (count (:liked-by message)) 0
                = (:task-stage message) :todo
                = (:task-stage message) :done
        [] :div ({} :style la/app)
          [] :div ({} :style la/sidebar)
            [] :div ({} :style la/sidebar-header)
              [] :div ({} :style wi/entry-icon :on-click go-home) |Home
              hspace 10
              [] :div ({} :style wi/entry-icon :on-click create-channel) |＋
              hspace 20
              [] :div ({} :style wi/switch-menu)
                [] :span ({} :style wi/switch-menu-label :on-click view-by-activity) "|by activity"
                hspace 6
                [] :span ({} :style wi/switch-menu-label :on-click view-by-create-time) "|by create time"
            hr
            [] :div ({} :style la/sidebar-body)
              channel-list (:channels store) (:grouped-users store) @order send
          vr
          [] :div ({} :style la/body)
            [] :div ({} :style la/body-header)
              if (some? channel-id)
                [] :div ({} :style la/header-info)
                  [] :div ({} :style la/header-title) (:title channel)
                  ->> (get (:grouped-users store) (:id channel))
                    map $ fn (user)
                      member-avatar user :small send
                [] :div ({} :style la/header-info) "|No channel selected"
              [] :div ({} :style la/header-cornor :on-click check-profile)
                member-avatar user :normal send
            hr
            [] :div ({} :style (merge la/flex la/row))
              [] :div ({} :style (merge la/flex la/column))
                [] :div ({} :style la/body-body :id :scroll)
                  message-list (:seen-messages store) store dirty-chan send
                hr
                if (some? channel-id)
                  [] :div ({} :style la/body-footer)
                    [] message-box dirty-chan send
              vr
              [] :div ({} :style (merge la/flex la/column))
                message-collection collected-messages store dirty-chan send
