
ns pickchat.component.welcome-page
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] vspace hspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn login-column (send)
  let
      username $ r/atom |
      password $ r/atom |
      update-name $ fn (event)
        reset! username $ -> event .-target .-value
      update-password $ fn (event)
        reset! password $ -> event .-target .-value
      submit $ fn (event)
        send :user/login $ {} :username @username :password @password
        reset! username |
        reset! password |
    fn (send)
      [] :div ({} :style la/login-column)
        [] :textarea $ {} :style wi/login-textbox :placeholder |Username :value @username :on-change update-name
        vspace 20
        [] :textarea $ {} :style wi/login-textbox :placeholder |Password :value @password :on-change update-password
        vspace 20
        [] :div ({} :style la/action-bar)
          [] :div ({} :style wi/button) |Submit

defn signup-column (send)
  let
      username $ r/atom |
      password $ r/atom |
      update-name $ fn (event)
        reset! username $ -> event .-target .-value
      update-password $ fn (event)
        reset! password $ -> event .-target .-value
      submit $ fn (event)
        send :user/signup $ {} :username @username :password @password
        reset! username |
        reset! password |
    fn (send)
      [] :div ({} :style la/login-column)
        [] :textarea $ {} :style wi/login-textbox :placeholder |Username :value @username :on-change update-name
        vspace 20
        [] :textarea $ {} :style wi/login-textbox :placeholder |Password :value @password :on-change update-password
        vspace 20
        [] :div ({} :style la/action-bar)
          [] :div ({} :style wi/button) |Submit

defn welcome-page (send)
  fn (send)
    [] :div ({} :style la/app)
      [] login-column send
      [] signup-column send
