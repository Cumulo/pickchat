
ns pickchat.expand
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn expand (db state-id)
  let
      state $ get-in db $ [] :states state-id
    if (some? (:user-id state))
      assoc schema/store
        , :state state
        , :users $ :users db
        , :user $ get-in db $ [] :users (:user-id state)
      assoc schema/store
        , :state state
