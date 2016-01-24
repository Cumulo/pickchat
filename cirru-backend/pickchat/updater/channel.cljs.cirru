
ns pickchat.updater.channel
  :require
    [] pickchat.schema :as schema

defn create (db action-data action-meta)
  let
      channel-id $ :id action-meta
      state-id $ :state-id action-meta
      user-id $ get-in db $ [] :states state-id :user-id
    assoc-in db ([] :channels channel-id)
      assoc schema/channel :id channel-id :title action-data
        , :author-id user-id :member-ids ([] user-id) :time (:time action-meta)
