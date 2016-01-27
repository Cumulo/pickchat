
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

def center $ {}
  :display :flex
  :flex-direction :row
  :align-items :center
  :justify-content :center

def center-content $ merge row $ {}
  :justify-content |center
  :padding |40px

def sidebar $ merge column $ {}
  :width |40%

def sidebar-header $ merge row center $ {}
  :height 60

def sidebar-body $ merge flex $ {}
  :overflow-y :auto

def app $ merge row $ {}
  :flex-shrink 0
  :margin "|0px"
  :width 500
  :position :absolute
  :width |100%
  :height |100%

def body $ merge flex column $ {}

def body-header $ merge row center $ {}
  :height 60
  :font-family "|Helvetica Neue Light, Century Gothic"

def body-body $ merge flex $ {}
  :overflow-y :auto

def body-footer $ merge row $ {}
  :height 60
  :background-color $ hsl 0 0 80

def login-column $ merge column $ {}
  :width 440
  :padding "|40px"

def action-bar $ merge row $ {}
  :justify-content :flex-end

def noop $ {}

def header-cornor $ {}
  :width |40px
  :cursor :pointer

def form $ merge column $ {}
  :padding "|20px"

def form-line $ merge row $ {}
  :margin-bottom |10px

def form-field $ {}
  :width |100px

def form-value $ {}

def header-title $ merge center $ {}
  :margin-right 20

def header-info $ merge row center flex $ {}

def message-list $ merge column flex $ {}
  :margin "|200px 0 400px"
