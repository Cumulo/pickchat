
ns pickchat.updater.core
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.updater.state :as up-state
    [] pickchat.updater.user :as up-user

defn updater (db action-type action-data action-meta)
  let
      handler $ case action-type
        :state/connect up-state/connect
        :state/disconnect up-state/disconnect

        :user/login up-user/login
        :user/signup up-user/signup
        :user/logout up-user/logout

        , identity
    handler db action-data action-meta
