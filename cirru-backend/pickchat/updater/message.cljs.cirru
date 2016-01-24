
ns pickchat.updater.message
  :require
    [] pickchat.schema :as schema

defn create (db action-data action-meta)
  let
      message-id $ :id action-meta
      state-id $ :state-id action-meta
      user-id $ get-in db $ [] :states state-id :user-id
      channel-id $ get-in db $ [] :states state-id :channel-id
    assoc-in db ([] :messages message-id)
      assoc schema/message :id message-id :text action-data
        , :author-id user-id :time (:time action-meta)
        , :channel-id channel-id
