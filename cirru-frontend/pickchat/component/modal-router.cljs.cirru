
ns pickchat.component.modal-router
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] imput hspace vspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn render-profile (modal-data store send)
  let
      user $ :user store
      on-name-change $ fn (text)
        send :user/username $ {} :id (:id user) :username text
      on-password-change $ fn (text)
        send :user/password $ {} :id (:id user) :password text
      on-avatar-change $ fn (text)
        send :user/avatar $ {} :id (:id user) :avatar text
    [] :div ({} :style la/form)
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Name
        [] imput $ {} :style wi/form-textbox :value (:username user) :on-change on-name-change
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Password
        [] imput $ {} :style wi/form-textbox :value (:password user) :on-change on-password-change
      [] :div ({} :style la/form-line)
        [] :div ({} :style la/form-field) |Avatar
        [] :div ({} :style la/form-value)
          [] imput $ {} :style wi/form-textbox :value (:avatar user) :on-change on-avatar-change
          vspace 10
          [] :img $ {} :style wi/avatar :src (:avatar user)

defn renderer (modal-data store send)
  case (:name modal-data)
    :profile $ render-profile (:data modal-data) store send
    [] :div nil (pr-str modal-data)
