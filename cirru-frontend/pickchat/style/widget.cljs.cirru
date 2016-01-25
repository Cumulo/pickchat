
ns pickchat.style.widget
  :require
    [] reagent.core :as r
    [] hsl.core :refer $ [] hsl
    [] pickchat.style.layout :as la

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
  :font-family "|Verdana"

def textbox $ {}
  :display :inline-block
  :height 30
  :color $ hsl 0 0 20
  :width :300px
  :padding "|0 10px"
  :font-size |14px
  :border :none
  :background-color $ hsl 0 0 96
  :outline :none
  :resize :none

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
  :font-family "|Helvetica Neue Light, Century Gothic"

def message-box $ {}
  :flex 1
  :border :none
  :outline :none
  :font-size 16
  :font-family "|Verdana"
  :padding "|4px 8px"

def login-textbox $ merge textbox $ {}
  :width |100%

defn notice-by (index) $ {}
  :background-color $ hsl 0 80 80
  :position :absolute
  :right 10
  :top $ + 10 $ * index 70
  :height 60
  :width 240
  :padding "|10px"
  :cursor :pointer

def notice-text $ {}
  :color :white

def modal-container $ merge la/fullscreen la/center $ {}
  :background-color $ hsl 0 0 30 0.6

def modal-card $ {}
  :min-width 400
  :min-height 200
  :background-color :white
  :flex-shrink 0
  :margin :auto

def form-textbox $ merge textbox $ {}
  :height |30px

def avatar $ {}
  :width 120
  :height 120

def entry-icon $ merge la/row la/center $ {}
  :width :auto
  :height |30px
  :background-color $ hsl 0 0 94
  :font-size 20
  :cursor :pointer
  :padding "|0 10px"
  :font-family "|Helvetica Neue Light, Century Gothic"

def channel $ {}
  :line-height |30px
  :padding |10px
  :font-size 16
  :font-family "|Verdana"
  :border-bottom $ str "|1px solid " (hsl 0 0 90)
  :cursor :pointer

def message $ merge la/row $ {}
  :padding "|10px"
  :font-family "|Verdana"

def default-avatar |http://tp3.sinaimg.cn/2091311042/180/5599392933/1

defn message-avatar (url) $ {}
  :width 40
  :height 40
  :border-radius 20
  :background-color $ hsl 0 0 90
  :background-size :cover
  :background-image $ str "|url(" (if (some? url) url default-avatar) "|)"

defn main-avatar (url) $ {}
  :width 40
  :height 40
  :border-radius 20
  :background-color $ hsl 0 0 90
  :background-size :cover
  :background-image $ str "|url(" url "|)"

def hr $ {}
  :width |100%
  :height |1px
  :background-color $ hsl 0 0 90

def vr $ {}
  :width 1
  :height |100%
  :background-color $ hsl 0 0 90

def message-detail $ merge la/column $ {}

def message-time $ {}
  :font-size 14
  :color $ hsl 0 0 80
