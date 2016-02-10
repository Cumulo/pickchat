
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
  [] :div ({}) "|path"

defn render-info (data original-path update-path)
  let
      on-click $ fn (event)
        println |click original-path
    [] :div ({} :style wi/viewer-info :on-click on-click)
      cond
        (map? data) |hashmap
        (vector? data) |vector
        (list? data) |list
        :else |literal

defn render-literal (data)
  [] :div ({} :style wi/viewer-literal)
    str data

defn iterate-hashmap (acc data original-path update-path)
  if (= (count data) 0) acc
    let
        entry $ first data
      recur
        conj acc
          [] :div ({} :key (first entry) :style wi/viewer-entry)
            [] :div ({}) $ render-literal (first entry)
            hspace 10
            [] :div ({}) $ render-info (last entry) original-path update-path
        dissoc data (first entry)
        , original-path update-path

defn render-hashmap (data original-path update-path)
  iterate-hashmap (list) data original-path update-path

defn render-vector (data update-path) |vector

defn render-list (data update-path) |list

defn render-column (data counter original-path update-path)
  [] :div ({} :style wi/viewer-column :key counter)
    cond
      (map? data) $ render-hashmap data original-path update-path
      (vector? data) $ render-vector data update-path
      (list? data) $ render-list data update-path
      :else $ render-literal data

defn render-table (acc data path counter original-path update-path)
  if (= (count path) 0)
    conj acc
      render-column data counter original-path update-path
    let
        path-header $ first path
      recur
        conj acc $ render-column data counter original-path update-path
        get data path-header
        rest path
        + counter 1
        , original-path update-path

defn edn-viewer (store send)
  let
      path $ r/atom $ [] :state
      update-path $ fn (new-path)
        reset! path new-path
    [] :div ({} :style (merge la/fullscreen viewer))
      path-panel @path
      [] :div ({} :style wi/viewer-table)
        render-table (list) store @path 0 @path update-path
