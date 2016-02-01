
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

defn leave (db action-data action-meta)
  assoc-in db ([] :states (:state-id action-meta) :channel-id) nil

defn enter (db action-data action-meta)
  assoc-in db ([] :states (:state-id action-meta) :channel-id) action-data

defn create-private (db action-data action-meta)
  let
      channel-id $ :id action-meta
      state-id $ :state-id action-meta
      user-id $ get-in db $ [] :states state-id :user-id
      member-id action-data
    assoc-in db ([] :channels channel-id)
      assoc schema/channel :id channel-id :title "|Between"
        , :author-id user-id :time (:time action-meta) :is-private true
        , :member-ids ([] user-id member-id)
