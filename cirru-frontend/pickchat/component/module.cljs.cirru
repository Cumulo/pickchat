
ns pickchat.component.module
  :require
    [] reagent.core :as r
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

defn get-time-value ()
  .valueOf (new js/Date)

defn imput (props)
  let
      text $ r/atom |
      time $ r/atom 0
      on-change $ :on-change props
      on-local-change $ fn (event)
        on-change (-> event (.-target) (.-value))
        reset! time (get-time-value)
        reset! text (-> event (.-target) (.-value))
    fn (props)
      [] :input $ {}
        :style (:style props)
        :value $ if (> @time (:time props)) @text (:value props)
        :on-change on-local-change
        :placeholder (:placeholder props)