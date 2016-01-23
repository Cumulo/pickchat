
ns pickchat.component.modal
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.modal-router :refer
      [] renderer

defn modal (modal-data store send)
  let
      on-click $ fn (event)
        send :modal/remove-one (:id modal-data)
        .stopPropagation event
      on-box-click $ fn (event)
        send :modal/hit-card (:id modal-data)
        .stopPropagation event
    [] :div ({} :key (:id modal-data) :style wi/modal-container :on-click on-click)
      [] :div ({} :style wi/modal-card :on-click on-box-click)
        renderer modal-data store send

defn popover (modal-data send)
  [] :div ({} :key (:id modal-data) :style wi/modal-container)
    [] :div ({} :style wi/modal-card)

defn modal-stack (modals store send)
  fn (modals store send)
    [] :div ({} :style la/noop)
      ->> modals
        map $ fn (modal-data)
          case (:type modal-data)
            :modal $ modal modal-data store send
            :popover $ popover modal-data send
            [] :div
