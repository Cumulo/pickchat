(defproject cumulo/pickchat "0.1.0"
  :description "Catalyst as todolist demo"
  :url "http://github.com/Cumulo/pickchat"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.7.228"]
                 [reagent "0.5.1"]
                 [hiccup "1.0.5"]
                 [binaryage/devtools "0.4.1"]
                 [differ "0.2.2"]
                 [mvc-works/hsl "0.1.1"]
                 [org.clojure/core.async "0.2.374"]]
  :plugins [[cirru/lein-sepal "0.0.15"]
            [mvc-works/lein-html-entry "0.0.2"]
            [lein-cljsbuild "1.1.2"]
            [lein-figwheel "0.5.0-3"]]
  :cirru-sepal {:paths ["cirru-frontend" "cirru-html" "cirru-backend"]}
  :html-entry {:file "html/html.clj" :output "resources/public/index.html"}
  :clean-targets ^{:protect false} [:target-path "resources/public/cljs"]
  :main ^:skip-aot pickchat.core
  :target-path "target/%s"
  :cljsbuild {:builds {:web-dev {:source-paths ["frontend"]
                             :figwheel {:websocket-host "repo"}
                             :compiler {:main pickchat.core
                                        :asset-path "cljs/out"
                                        :output-to  "resources/public/cljs/main.js"
                                        :output-dir "resources/public/cljs/out"}}
                       :web-prod {:source-paths ["frontend"]
                              :compiler {:output-to "resources/public/cljs/main.js"
                                         :optimizations :advanced
                                         :pretty-print false}}
                       :server-dev {:source-paths ["backend"]
                                    :figwheel true
                                    :compiler {
                                      :main pickchat.server
                                      :output-to "target/server.js"
                                      :output-dir "target/server_dev"
                                      :target :nodejs
                                      :optimizations :none
                                      :source-map true}}
                       :server-prod {:source-paths ["backend"]
                                     :compiler {:output-to "target/server.js"
                                                :output-dir "target/server_prod"
                                                :target :nodejs
                                                :optimizations :simple}}}}
  :figwheel {:css-dirs ["resources/public/css"]
             :load-warninged-code false}
  :profiles {:uberjar {:aot :all}}
  :parallel-build true)
