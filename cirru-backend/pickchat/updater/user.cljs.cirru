
ns pickchat.updater.user
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn login (db action-data action-meta)
  let
      state-id $ :state-id action-meta
      state $ get-in db $ [] :state state-id
      maybe-user $ some
        fn (user-entry)
          and
            = (:name (get user-entry 1)) (:username action-data)
            = (:password (get user-entry 1)) (:password action-data)
        :user db
    if (some? maybe-user)
      assoc-in db ([] :states state-id) (:id maybe-user)
      update-in db ([] :state state-id :notifications)
        fn (notifications)
          conj notifications $ assoc schema/notice
            , :id (:id action-meta)
            , :text "|no user"
