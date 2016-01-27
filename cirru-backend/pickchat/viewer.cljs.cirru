
ns pickchat.viewer
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn framing (scene state-id db)
  let
      state $ get-in db $ [] :states state-id
      channel-id $ :channel-id state
    if (some? (:user-id state))
      assoc schema/store
        , :state state
        , :users $ :users db
        , :user $ get-in db $ [] :users (:user-id state)
        , :channels $ :channels scene
        , :grouped-users $ :grouped-users scene
        , :seen-messages $ if (some? channel-id)
          get (:seen-messages scene) channel-id
      assoc schema/store
        , :state state
