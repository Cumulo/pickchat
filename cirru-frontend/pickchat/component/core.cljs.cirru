
ns pickchat.component.core
  :require
    [] reagent.core :as r
    [] pickchat.style.layout :as la
    [] pickchat.style.widget :as wi

defn task (task)

defn hspace (x)
  [] :div
    {} :style
      merge la/hspace $ {} :width x

defn vspace (x)
  [] :div
    {} :style
      merge la/vspace $ {} :height x

defn task-comp ()
  let
      draft $ atom |
      local-time $ atom 1
    fn (task send)
      let
          on-remove-task $ fn (event)
            send :task/remove (:id task)
          on-change $ fn (event)
            reset! draft (.-value (.-target event))
            reset! local-time $ .valueOf (new js/Date)
            send :task/text $ {} :id (:id task) :text (.-value (.-target event))
        [] :div ({} :style wi/task)
          [] :input $ {}
            :style wi/textbox
            :value $ if (> @local-time (:time task)) @draft (:text task)
            :on-change on-change
          hspace 10
          [] :div ({} :style wi/icon :on-click on-remove-task) |✕

defn page ()
  let
      draft $ r/atom |
      on-draft-change $ fn (event)
        reset! draft (-> event .-target .-value)
    fn (store send)
      println store
      let
          on-create $ fn (event)
            if (> (count @draft) 0)
              do
                send :task/create @draft
                reset! draft |
        [] :div ({} :style la/fullscreen)
          [] :div ({} :style wi/app)
            [] :input ({} :style wi/textbox :value @draft :on-change on-draft-change :placeholder "|draft")
            hspace 10
            [] :button ({} :style wi/button :on-click on-create) |Submit
            ->> (:tasks store)
              map $ fn (entry) (get entry 1)
              sort-by $ fn (task) (- 0 (:time task))
              map $ fn (task)
                [] :div ({} :key (:id task))
                  [] task-comp task send
