
ns pickchat.expand
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn expand (db state-id)
  let
      state $ get-in db $ [] :states state-id
      channel-id $ :channel-id state

    if (some? (:user-id state))
      assoc schema/store
        , :state state
        , :users $ :users db
        , :user $ get-in db $ [] :users (:user-id state)
        , :channels $ :channels db
        , :seen-messages $ if (some? channel-id)
          ->> (:messages db)
            map last
            filter $ fn (message)
              = (:channel-id message) channel-id
            sort $ fn (msg-a msg-b)
              cond
                (< (:time msg-a) (:time msg-b)) -1
                (> (:time msg-a) (:time msg-b)) 1
                :else 0
      assoc schema/store
        , :state state
