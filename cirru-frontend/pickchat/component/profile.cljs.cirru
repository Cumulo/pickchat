
ns pickchat.component.profile
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] imput hspace vspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn render-my-profile (modal-data store send)
  let
      user $ :user store
      on-name-change $ fn (text)
        send :user/nickname $ {} :id (:id user) :nickname text
      on-password-change $ fn (text)
        send :user/password $ {} :id (:id user) :password text
      on-avatar-change $ fn (text)
        send :user/avatar $ {} :id (:id user) :avatar text
      on-logout $ fn (event)
        send :modal/remove-one (:id modal-data)
        send :user/logout
    [] :div ({} :style la/form)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Username
        [] :div ({} :style la/form-value) (:username user)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Nickname
        [] imput $ {} :style wi/form-textbox :value (:nickname user) :on-change on-name-change
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Password
        [] imput $ {} :style wi/form-textbox :value (:password user) :on-change on-password-change
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Avatar
        [] :div ({} :style la/form-value)
          [] imput $ {} :style wi/form-textbox :value (:avatar user) :on-change on-avatar-change
          vspace 10
          [] :img $ {} :style wi/avatar :src (:avatar user)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Logout
        [] :div ({} :style la/form-value)
          [] :div ({} :style wi/button :on-click on-logout) |Logout

defn render-member-profile (modal-data store send)
  let
      member-id $ :data modal-data
      member $ get-in store ([] :users member-id)
      start-chat $ fn (event)
        .stopPropagation event
        send :modal/remove-one (:id modal-data)
        send :channel/create-private (:data modal-data)
    [] :div ({} :style la/form)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Nickname
        [] :div ({} :style la/form-value) (:nickname member)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Avatar
        [] :div ({} :style la/form-value)
          [] :img $ {} :style wi/avatar :src (:avatar member)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) "|Private Message"
        [] :div ({} :style la/form-value)
          [] :div ({} :style wi/button :on-click start-chat) |Hi
