
ns pickchat.updater.core
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.updater.state :as up-state
    [] pickchat.updater.user :as up-user
    [] pickchat.updater.modal :as up-modal

defn updater (db action-type action-data action-meta)
  let
      handler $ case action-type
        :state/connect up-state/connect
        :state/disconnect up-state/disconnect
        :state/read-notice up-state/read-notice

        :user/login up-user/login
        :user/signup up-user/signup
        :user/logout up-user/logout
        :user/nickname up-user/nickname
        :user/password up-user/password
        :user/avatar up-user/avatar

        :modal/add up-modal/add
        :modal/remove-one up-modal/remove-one
        :modal/hit-card up-modal/hit-card

        , identity
    handler db action-data action-meta
