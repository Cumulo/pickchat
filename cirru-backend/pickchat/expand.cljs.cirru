
ns pickchat.expand
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn expand (db state-id)
  let
      state $ get-in db $ [] :states state-id
    if (string? (:user-id state))
      assoc schema/store
        , :state state
      assoc schema/store
        , :state state
        , :users $ :users db
