
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

defn render-create-channel (modal-data store send)
  let
      text $ r/atom |
      on-change $ fn (event)
        println :change  $ -> event (.-target) (.-value)
        reset! text $ -> event (.-target) (.-value)
      submit $ fn (event)
        send :channel/create @text
        send :modal/remove-one (:id modal-data)
    fn (modal-data store send)
      [] :div ({} :style la/form)
        [] :div ({} :style la/form-line)
          [] :div ({} :style la/form-field) |Topic
          [] :input $ {} :style wi/form-textbox :on-change on-change :value @text :placeholder |Topic
        [] :div ({} :style la/action-bar)
          [] :div ({} :style wi/button :on-click submit) |Submit

defn renderer (modal-data store send)
  case (:name modal-data)
    :profile $ render-profile modal-data store send
    :create-channel $ [] render-create-channel modal-data store send
    [] :div nil (pr-str modal-data)
