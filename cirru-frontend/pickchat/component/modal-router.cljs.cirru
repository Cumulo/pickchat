
ns pickchat.component.modal-router
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] imput hspace vspace
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi
    [] pickchat.component.channel :refer
      [] render-create-channel
    [] pickchat.component.profile :refer
      [] render-my-profile

defn renderer (modal-data store send)
  case (:name modal-data)
    :profile $ render-my-profile modal-data store send
    :create-channel $ [] render-create-channel modal-data store send
    [] :div nil (pr-str modal-data)
