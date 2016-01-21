
ns pickchat.style.widget
  :require
    [] reagent.core :as r
    [] hsl.core :refer $ [] hsl

def button $ {}
  :display |inline-block
  :background-color $ hsl 200 80 50
  :color |white
  :border |none
  :height 30
  :line-height |30px
  :font-size |16px
  :padding "|0 20px"
  :border-radius 15
  :cursor |pointer
  :outline |none

def textbox $ {}
  :display |inline-block
  :line-height |30px
  :color $ hsl 0 0 20
  :width :300px
  :padding "|0 10px"
  :font-size |14px
  :border |none
  :background-color $ hsl 0 0 96
  :outline |none

def icon $ {}
  :width 20
  :height 20
  :font-size 12
  :font-weight 100
  :display |flex
  :flex-direction |row
  :justify-content |center
  :align-items |center
  :color $ hsl 0 0 100
  :background-color $ hsl 0 80 90
  :border-radius 10
  :cursor |pointer

def message-box $ {}
  :flex 1
  :border :none
  :outline :none
  :font-size 16
  :font-family "|Verdana"
  :padding "|4px 8px"
