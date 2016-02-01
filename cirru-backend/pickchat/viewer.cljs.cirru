
ns pickchat.viewer
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn framing (scene state-id db)
  let
      state $ get-in db $ [] :states state-id
      channel-id $ :channel-id state
      user-id $ :user-id state
    if (some? user-id)
      assoc schema/store
        , :state state
        , :users $ :users db
        , :user $ get-in db $ [] :users (:user-id state)
        , :channels $ into ({}) $ ->> (:channels scene)
          filter $ fn (channel-entry)
            let
                channel $ last channel-entry
              if (:is-private channel)
                some (fn (item) (= item user-id)) (:member-ids channel)
                , true
        , :grouped-users $ :grouped-users scene
        , :seen-messages $ if (some? channel-id)
          get (:seen-messages scene) channel-id
      assoc schema/store
        , :state state
