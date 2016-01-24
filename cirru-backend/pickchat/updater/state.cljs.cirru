
ns pickchat.updater.state
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn connect (db action-data action-meta)
  assoc-in db
    [] :states (:state-id action-meta)
    , schema/state

defn disconnect (db action-data action-meta)
  update db :states $ fn (states)
    dissoc db :states (:state-id action-meta)

defn read-notice (db action-data action-meta)
  let
      state-id $ :state-id action-meta
    update-in db ([] :states state-id :notifications)
      fn (notications)
        ->> notications
          remove $ fn (notice)
            = (:id notice) action-data
