
ns pickchat.util.format
  :require
    [] reagent.core :as r

def s "| "

defn two-digits (n)
  if (< n 10)
    str |0 n
    str n

defn display-time (unix-secs)
  let
      time-obj $ new js/Date unix-secs
      year $ .getFullYear time-obj
      month $ + 1 $ .getMonth time-obj
      date $ .getDate time-obj
      hours $ .getHours time-obj
      mins $ .getMinutes time-obj
    str (two-digits month) |- (two-digits date) s (two-digits hours) |: (two-digits mins)
