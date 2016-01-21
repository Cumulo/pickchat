
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
    dissoc states (:state-id action-meta)
