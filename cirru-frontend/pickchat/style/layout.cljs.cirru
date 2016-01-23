
ns pickchat.style.layout
  :require
    [] reagent.core :as r
    [] hsl.core :refer $ [] hsl

def fullscreen $ {}
  :width |100%
  :height |100%
  :position |absolute
  :top 0
  :left 0
  :overflow |auto

def hspace $ {}
  :height 1
  :vertical-align |middle
  :display |inline-block

def vspace $ {}
  :width |100%

def row $ {}
  :display :flex
  :flex-direction :row
  :align-items :stretch

def column $ {}
  :display :flex
  :flex-direction :column
  :align-items :stretch

def flex $ {}
  :flex 1

def center-content $ merge row $ {}
  :justify-content |center
  :padding |40px

def sidebar $ merge column $ {}
  :width |300px
  :background-color $ hsl 0 0 90

def sidebar-header $ {}
  :height 60
  :background-color $ hsl 0 0 70

def sidebar-body $ merge flex

def app $ merge row $ {}
  :flex-shrink 0
  :margin "|0px"
  :width 500
  :position :absolute
  :width |100%
  :height |100%

def body $ merge flex column $ {}
  :background-color $ hsl 0 0 94

def body-header $ merge row $ {}
  :height 60
  :background-color $ hsl 0 0 80

def body-body $ merge flex

def body-footer $ merge row $ {}
  :height 60
  :background-color $ hsl 0 0 80

def login-column $ merge column $ {}
  :background-color $ hsl 0 60 80
  :width 320
  :padding "|40px"

def action-bar $ merge row $ {}
  :justify-content :flex-end

def noop $ {}

def header-cornor $ {}
  :width |40px
  :background-color $ hsl 0 0 30

def center $ {}
  :display :flex
  :flex-direction :row
  :align-items :center
  :justify-content :center
