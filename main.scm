(cond-expand
  (csi (load "raylib/raylib.so"))
  (else (include "raylib/raylib.scm")))

(import scheme
        (chicken base)
        raylib)

(include "updaters")

(define (main)
  (init-window 800 600 "tetris")
  (let loop ()
    (let ([dt (get-frame-time)])
      (run-updaters dt)
      (with-drawing
       (clear-background color/darkgray)
       (run-drawers dt)))
    (unless (window-should-close?) (loop)))
  (close-window))

(main)
