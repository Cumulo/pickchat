
ns pickchat.style.layout
  :require
    [] reagent.core :as r

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

def center-content $ {}
  :display |flex
  :flex-direction |row
  :justify-content |center
  :align-items |center
  :padding |40px
