
ns pickchat.scene
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn get-channel-users (db the-id)
  ->> (:states db)
    map last
    filter $ fn (state)
      = (:channel-id state) the-id
    map $ fn (state)
      :user-id state
    filter some?
    map $ fn (user-id)
      get-in db $ [] :users user-id

defn erect (db)
  assoc schema/scene
    , :channels $ into ({}) $ ->> (:channels db)
      map $ fn (channel-entry)
        update-in channel-entry ([] 1) $ fn (channel)
          let
              last-message-id $ :last-message-id channel
            if (some? last-message-id)
              let
                  last-message $ get-in db ([] :messages last-message-id)
                  last-author $ get-in db ([] :users (:author-id last-message))
                  current-users $ get-channel-users db (:id channel)
                assoc channel :last-message last-message :last-author last-author
                  , :current-users current-users
              , channel
    , :seen-messages $ into ({}) $ ->> (:channels db)
      map $ fn (channel-entry)
        update-in channel-entry ([] 1) $ fn (channel)
          ->> (:messages db)
            map last
            filter $ fn (message)
              = (:channel-id message) (:id channel)
            sort $ fn (msg-a msg-b)
              cond
                (< (:time msg-a) (:time msg-b)) -1
                (> (:time msg-a) (:time msg-b)) 1
                :else 0
