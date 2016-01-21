
ns pickchat.component.module
  :require
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn hspace (x)
  [] :div
    {} :style
      merge la/hspace $ {} :width x

defn vspace (x)
  [] :div
    {} :style
      merge la/vspace $ {} :height x
