(cond-expand
  (csi (load "raylib/raylib.so"))
  (else (include "raylib/raylib.scm")))

(import scheme
        (chicken base)
        (only (chicken format) format)
        (only (chicken keyword) keyword->string)
        (only (chicken platform) features)
        (only (chicken time) current-seconds)
        (only srfi-1 filter)
        (only srfi-13 string-join)
        raylib)

(define repl-features '(#:srfi-18 #:srfi-4 #:srfi-69 #:srfi-1 #:csi #:srfi-28 #:srfi-31 #:srfi-26 #:srfi-16 #:srfi-15 #:srfi-11 #:srfi-0 #:srfi-2 #:srfi-6 #:srfi-9 #:srfi-46 #:srfi-55 #:srfi-61 #:chicken-5 #:chicken-5.3 #:64bit #:ptables #:dload #:little-endian #:x86-64 #:gnu #:linux #:unix #:chicken #:srfi-6 #:srfi-8 #:srfi-12 #:srfi-17 #:srfi-23 #:srfi-30 #:srfi-39 #:srfi-62 #:srfi-87 #:srfi-88 #:full-numeric-tower #:srfi-13 #:srfi-14))

(define unique-features
  (filter (lambda (x) (not (member x repl-features))) (features)))
(define missing-features
  (filter (lambda (x) (not (member x (features)))) repl-features))

(define (stringify ftrs)
  (string-join (map keyword->string ftrs) "\n"))
(set! unique-features (stringify unique-features))
(set! missing-features (stringify missing-features))

(init-window 0 0 "testing features")
(unless (is-window-fullscreen?) (toggle-fullscreen))

(define frames 0)
(define last-fps 0)
(define last-seconds 0)
(define (tick)
  (let ([cur-seconds (current-seconds)])
    (if (not (= cur-seconds last-seconds))
        (begin
          (set! last-seconds cur-seconds)
          (set! last-fps frames)
          (set! frames 0)
          last-fps)
        (begin
          (set! frames (add1 frames))
          last-fps))))

(let loop ()
  (with-drawing
   (clear-background color/black)
   (draw-text unique-features 20 20 20 color/raywhite)
   (draw-text missing-features 600 20 20 color/raywhite)
   (draw-text (format "~a" (tick)) 1800 20 20 color/beige))
  (unless (window-should-close?) (loop)))

(close-window)
