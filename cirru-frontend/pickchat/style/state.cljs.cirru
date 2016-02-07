
ns pickchat.style.state
  :require
    [] hsl.core :refer $ [] hsl
    [] pickchat.style.layout :as la

def icon-active $ {}
  :opacity 1
  :vertical-align :middle

def icon-inactive $ {}
  :opacity 0.4
  :vertical-align :middle
