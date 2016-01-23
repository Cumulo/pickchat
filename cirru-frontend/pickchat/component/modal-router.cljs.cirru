
ns pickchat.component.modal-router
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn render-profile (modal-data store send)
  [] :div ({} :style la/noop) "|profile"

defn renderer (modal-data store send)
  case (:name modal-data)
    :profile $ render-profile (:data modal-data) store send
    [] :div nil (pr-str modal-data)
