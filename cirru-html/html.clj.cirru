
require $ quote $ [] hiccup.core :refer $ [] html

defn render (data)
  html
    [] :html
      [] :head
        [] :title "|PickChat"
        [] :link
          {} (:type |text/css) (:href |css/style.css) (:rel |stylesheet)
        [] :link
          {} (:type |image/png) (:rel |icon) (:href |images/discourse.png)
      [] :body
        [] :div#app
        [] :script
          {} (:src "|cljs/main.js")
