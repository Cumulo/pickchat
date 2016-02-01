
ns pickchat.updater.message
  :require
    [] pickchat.schema :as schema

defn create (db action-data action-meta)
  let
      message-id $ :id action-meta
      state-id $ :state-id action-meta
      user-id $ get-in db $ [] :states state-id :user-id
      channel-id $ get-in db $ [] :states state-id :channel-id
    -> db
      assoc-in ([] :messages message-id)
        assoc schema/message :id message-id :text action-data
          , :author-id user-id :time (:time action-meta)
          , :channel-id channel-id
      assoc-in ([] :channels channel-id :last-message-id) message-id
      assoc-in ([] :channels channel-id :last-message-time) (:time action-meta)

defn like (db action-data action-meta)
  let
      message-id action-data
      state-id $ :state-id action-meta
      user-id $ get-in db $ [] :states state-id :user-id
    update-in db ([] :messages message-id :liked-by)
      fn (liked-by)
        println liked-by
        if
          some (fn (item) (= item user-id)) liked-by
          remove (fn (member-id) (= member-id user-id)) liked-by
          conj liked-by user-id
