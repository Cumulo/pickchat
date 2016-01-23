
ns pickchat.updater.user
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn login (db action-data action-meta)
  let
      state-id $ :state-id action-meta
      state $ get-in db $ [] :state state-id
      maybe-users $ ->> :users db
        map $ fn (user-entry)
          get user-entry 1
        filter $ fn (user)
          and
            = (:username user) (:username action-data)
            = (:password user) (:password action-data)
      maybe-user $ first maybe-users
    println maybe-users maybe-user
    if (some? maybe-user)
      assoc-in db ([] :states state-id :user-id) (:id maybe-user)
      update-in db ([] :states state-id :notifications)
        fn (notifications)
          conj notifications
            assoc schema/notification :id (:id action-meta) :text "|no user"

defn signup (db action-data action-meta)
  let
      state-id $ :state-id action-meta
      state $ get-in db $ [] :states state-id
      user-id $ :id action-meta
      maybe-user $ some
        fn (user-entry)
          = (:username (get user-entry 1)) (:username action-data)
        :users db
    if (some? maybe-user)
      update-in db ([] :states state-id :notifications)
        fn (notifications)
          conj notifications
            assoc schema/notification :id (:id action-data) :text "|name is taken"
      -> db
        assoc-in ([] :users user-id)
          assoc schema/user :id user-id :username (:username action-data) :password (:password action-data)
        assoc-in ([] :states state-id :user-id) user-id
