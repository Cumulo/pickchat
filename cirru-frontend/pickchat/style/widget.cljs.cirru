
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
  :line-height |30px
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
  :background-color $ hsl 300 80 70
  :color :white
  :border-radius 15
  :font-size 20
  :cursor :pointer
  :padding "|0 20px"
  :font-family "|Helvetica Neue Light, Century Gothic"

defn channel (is-private)
  merge la/column
    {}
      :line-height |30px
      :padding |10px
      :font-size 16
      :font-family "|Verdana"
      :border-bottom $ str "|1px solid " (hsl 0 0 90)
      :cursor :pointer
    if is-private
      {} :background-color (hsl 300 80 94)

def channel-update $ merge la/row $ {}
  :align-items :center
  :white-space :nowrap

def channel-update-author $ {}
  :color $ hsl 0 0 100
  :background-color $ hsl 200 80 80
  :padding "|0 10px"
  :border-radius 5
  :line-height |20px
  :height 20

def channel-update-content $ {}
  :color $ hsl 0 0 40
  :overflow :hidden
  :text-overflow :ellipsis

def channel-title $ {}
  :color $ hsl 0 0 80
  :margin-right 10

def channel-info $ merge la/row $ {}
  :align-items :center

def channel-members $ merge la/row $ {}

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
  :cursor :pointer

defn main-avatar (url) $ {}
  :width 40
  :height 40
  :border-radius 20
  :background-color $ hsl 0 0 90
  :background-size :cover
  :background-image $ str "|url(" url "|)"
  :cursor :pointer

defn small-avatar (url) $ {}
  :width 20
  :height 20
  :border-radius 10
  :background-color $ hsl 0 0 90
  :background-size :cover
  :background-image $ str "|url(" url "|)"
  :cursor :pointer

def hr $ {}
  :width |100%
  :height |1px
  :background-color $ hsl 0 0 90

def vr $ {}
  :width 1
  :background-color $ hsl 0 0 90

def message-detail $ merge la/column $ {}
  :flex 1

def message-time $ {}
  :font-size 14
  :color $ hsl 0 0 80

def switch-menu $ {}
  :font-size |12px
  :color $ hsl 0 0 100

def switch-menu-label $ {}
  :padding "|0 8px"
  :background-color $ hsl 0 0 80
  :border-radius 10
  :cursor :pointer

def icon-block $ {}
  :font-size 20
  :color $ hsl 0 100 60
  :display :inline-block
  :cursor :pointer
  :-webkit-user-select :none

defn heart-symbol (liked-by-me?)
  {}
    :font-size 18
    :vertical-align :middle
    :opacity $ if liked-by-me? 1 0.4

def heart-count $ {}
  :font-size 14
  :vertical-align :middle

def task-icon $ {}
  :font-size 15
  :vertical-align :middle

def viewer-table $ merge la/row $ {}
  :font-family "|Menlo"
  :font-size 14
  :line-height |24px

def viewer-column $ merge la/column $ {}
  :width :auto
  :padding "| 5px 10px"

def viewer-entry $ merge la/row $ {}
  :height 30
  :width :auto
  :align-items :center

def viewer-key $ {}
  :display :inline-block

def viewer-literal $ {}
  :display :inline-block
  :background-color $ hsl 240 80 80
  :color :white
  :padding "|0px 8px"

def viewer-info $ {}
  :display :inline-block
  :background-color $ hsl 300 80 80
  :color :white
  :padding "|0px 8px"
  :cursor :pointer

def viewer-path $ {}
  :padding "|5px 10px"
  :font-family "|Menlo"
  :font-size 14
  :line-height |24px
