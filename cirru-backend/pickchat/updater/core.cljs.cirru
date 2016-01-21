
ns pickchat.updater.core
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.updater.state :as up-state

defn updater (db action-type action-data action-meta)
  let
      handler $ case action-type
        :state/connect up-state/connect
        :state/disconnect up-state/disconnect
        , identity
    handler db action-data action-meta
