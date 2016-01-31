
ns pickchat.component.member
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.module :refer
      [] vspace hspace

defn member-avatar (member kind send)
  let
      show-member $ fn (event)
        .stopPropagation event
        send :modal/add $ {} :name :profile :type :modal :data (:id member)
      avatar $ :avatar member
    [] :div
      {} :style
        case kind
          :small $ wi/small-avatar avatar
          :normal $ wi/message-avatar avatar
          wi/message-avatar avatar
        , :on-click show-member :key (:id member)
