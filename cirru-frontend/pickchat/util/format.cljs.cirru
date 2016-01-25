
ns pickchat.util.format
  :require
    [] reagent.core :as r

def s "| "

defn display-time (unix-secs)
  let
      time-obj $ new js/Date unix-secs
      year $ .getFullYear time-obj
      month $ + 1 $ .getMonth time-obj
      date $ .getDate time-obj
      hours $ .getHours time-obj
      mins $ .getMinutes time-obj
    str month |- date s hours |: mins
