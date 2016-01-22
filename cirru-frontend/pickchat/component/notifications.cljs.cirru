
ns pickchat.component.notificaitons
  :require
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn notice (send)
  fn (send index)
    [] :div ({} :style wi/notice)

defn notificaitons (send)
  fn (send)
    [] :div ({} :style la/noop)
      map-indexed
        fn (index item)
          [] :div ({})
