
ns pickchat.component.edn-viewer
  :require
    [] reagent.core :as r
    [] pickchat.component.module :refer
      [] vspace hspace hr vr
    [] hsl.core :refer
      [] hsl
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

def viewer $ {}
  :z-index 100
  :background $ hsl 0 50 30 0.6

defn path-panel (path)
  [] :div ({})
    map-indexed
      fn (i segment)
        [] :div ({} :key i :style wi/viewer-literal) (pr-str segment)
      , path

defn render-info (data cursor k update-path)
  let
      on-click $ fn (event)
        if (coll? data)
          update-path (conj cursor k)
    [] :div ({} :style wi/viewer-info :on-click on-click)
      cond
        (map? data) $ str |hashmap: (count data)
        (vector? data) $ str |vector: (count data)
        (list? data) $ str |list: (count data)
        :else $ pr-str data

defn render-literal (data)
  [] :div ({} :style wi/viewer-literal)
    str data

defn render-hashmap (acc data cursor update-path)
  if (= (count data) 0) acc
    let
        entry $ first data
        k $ first entry
      recur
        conj acc
          [] :div ({} :key k :style wi/viewer-entry)
            render-literal k
            hspace 10
            render-info (last entry) cursor k update-path
        dissoc data k
        , cursor update-path

defn render-list (acc data cursor i update-path)
  if (= (count data) 0) acc
    let
        v $ get data i
      recur
        conj acc
          [] :div ({} :key i :style wi/viewer-entry)
            render-literal i
            hspace 10
            render-info v cursor i update-path
        rest data
        , cursor (+ 1 i) update-path

defn render-column (store cursor update-path)
  let
      counter $ count cursor
      data $ get-in store cursor
    [] :div ({} :style wi/viewer-column :key counter)
      cond
        (map? data) $ render-hashmap (list) data cursor update-path
        (vector? data) $ render-list (list) data cursor 0 update-path
        (list? data) $ render-list (list) data cursor 0 update-path
        :else $ render-literal data

defn render-table (acc store path0 counter update-path)
  let
      cursor $ subvec path0 0 counter
    if (= counter (count path0))
      reverse $ conj acc
        render-column store cursor update-path
      recur
        conj acc $ render-column store cursor update-path
        , store path0 (+ counter 1) update-path

defn edn-viewer (store send)
  let
      path $ r/atom $ []
      update-path $ fn (new-path)
        reset! path new-path
    fn (store send)
      [] :div ({} :style (merge la/fullscreen viewer))
        [] :div ({} :style wi/viewer-path)
          path-panel @path
        [] :div ({} :style wi/viewer-table)
          render-table (list) store @path 0 update-path
