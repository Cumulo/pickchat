
ns pickchat.updater.modal
  :require
    [] cljs.nodejs :as nodejs
    [] pickchat.schema :as schema

defn add (db action-data action-meta)
  let
      state-id $ :state-id action-meta
    update-in db ([] :states state-id :modals)
      fn (modals)
        conj modals
          assoc schema/modal :name (:name action-data) :id (:id action-meta)
            , :data (:data action-data) :type (:type action-data)

defn remove-one (db action-data action-meta)
  let
      state-id $ :state-id action-meta
    update-in db ([] :states state-id :modals)
      fn (modals)
        ->> modals
          remove $ fn (modal)
            = (:id modal) action-data

defn handle-hit-card (acc piece id is-found)
  if (= (count piece) 0) acc
    let
        cursor $ first piece
      if is-found
        if (= (:type cursor) :popover)
          recur acc (rest piece) id true
          recur (conj acc cursor) (rest piece) id true
        recur (conj acc cursor) (rest piece) id (= (:id cursor) id)


defn hit-card (db action-data action-meta)
  let
      state-id $ :state-id action-meta
    update-in db ([] :states state-id :modals)
      fn (modals)
        handle-hit-card ([]) modals action-data false
