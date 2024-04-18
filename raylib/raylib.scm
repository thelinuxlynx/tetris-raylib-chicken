(module raylib (init-window
                close-window
                window-should-close?
                is-window-fullscreen?
                toggle-fullscreen

                make-color make-rgb color?
                color-r color-r-set!
                color-g color-g-set!
                color-b color-b-set!
                color-a color-a-set!
                color/lightgray
                color/gray
                color/darkgray
                color/yellow
                color/gold
                color/orange
                color/pink
                color/red
                color/maroon
                color/green
                color/lime
                color/darkgreen
                color/skyblue
                color/blue
                color/darkblue
                color/purple
                color/violet
                color/darkpurple
                color/beige
                color/brown
                color/darkbrown
                color/white
                color/black
                color/blank
                color/magenta
                color/raywhite

                clear-background
                begin-drawing
                end-drawing
                with-drawing

                set-target-fps
                get-frame-time
                get-time
                get-fps

                draw-text)
  (import scheme
          (chicken base)
          (chicken syntax)
          (chicken foreign))
  (foreign-declare "#include \"raylib.h\"")
  (include "raylib/util")
  (include "raylib/rcore")
  ;; (include "rshapes")
  ;; (include "rtextures")
  ;; (include "rmodels")
  ;; (include "raudio")
  (include "raylib/rtext"))
