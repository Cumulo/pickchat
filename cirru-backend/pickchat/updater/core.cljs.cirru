
ns pickchat.updater.core
  :require
    [] cljs.nodejs :as nodejs

defn updater (db action-type action-data action-meta)
  let
      handler $ case action-type
        , identity
    handler db action-data action-meta
