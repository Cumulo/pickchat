
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
        if
          > (count @username) 0
          do
            send :user/login $ {} :username @username :password @password
            reset! username |
            reset! password |
      submit-signup $ fn (event)
        if
          > (count @username) 0
          do
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
          [] :div ({} :style wi/button :on-click submit) "|Log in"
          hspace 10
          [] :div ({} :style wi/button :on-click submit-signup) "|Sign up"

defn about-page ()
  [] :div ({} :style la/about-page)
    [] :div ({}) "|This is a simple chatroom made by jiyinyiyong."
    [] :div ({}) "|It's ugly but simple to see."

defn welcome-page (send)
  fn (send)
    [] :div ({} :style la/app)
      [] login-column send
      about-page
