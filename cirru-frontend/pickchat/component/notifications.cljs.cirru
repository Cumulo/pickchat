
ns pickchat.component.notifications
  :require
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn notice (item index send)
  let
      read $ fn (event)
        send :state/read-notice (:id item)
    [] :div ({} :style (wi/notice-by index) :key (:id item) :on-click read)
      [] :div ({} :style wi/notice-text) (:text item)

defn notifications (data send)
  fn (data send)
    [] :div ({} :style la/noop)
      map-indexed
        fn (index item)
          notice item index send
        , data
