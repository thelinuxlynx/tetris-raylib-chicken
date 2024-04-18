;; InitWindow
(f init-window
   InitWindow
   void
   int width int height c-string title)

;; CloseWindow
(f close-window
   CloseWindow
   void)

;; WindowShouldClose
(f window-should-close?
   WindowShouldClose
   bool)

;; IsWindowFullscreen
(f is-window-fullscreen?
   IsWindowFullscreen
   bool)

;; ToggleFullscreen
(f toggle-fullscreen
   ToggleFullscreen
   void)

(define-record color r g b a)

(define (make-rgb r g b)
  (make-color r g b 255))

;; TODO: make-hsv?

(define color/lightgray (make-color 200 200 200 255))
(define color/gray (make-color 130 130 130 255))
(define color/darkgray (make-color 80 80 80 255))
(define color/yellow (make-color 253 249 0 255))
(define color/gold (make-color 255 203 0 255))
(define color/orange (make-color 255 161 0 255))
(define color/pink (make-color 255 109 194 255))
(define color/red (make-color 230 41 55 255))
(define color/maroon (make-color 190 33 55 255))
(define color/green (make-color 0 228 48 255))
(define color/lime (make-color 0 158 47 255))
(define color/darkgreen (make-color 0 117 44 255))
(define color/skyblue (make-color 102 191 255 255))
(define color/blue (make-color 0 121 241 255))
(define color/darkblue (make-color 0 82 172 255))
(define color/purple (make-color 200 122 255 255))
(define color/violet (make-color 135 60 190 255))
(define color/darkpurple (make-color 112 31 126 255))
(define color/beige (make-color 211 176 131 255))
(define color/brown (make-color 127 106 79 255))
(define color/darkbrown (make-color 76 63 47 255))
(define color/white (make-color 255 255 255 255))
(define color/black (make-color 0 0 0 255))
(define color/blank (make-color 0 0 0 0))
(define color/magenta (make-color 255 0 255 255))
(define color/raywhite (make-color 245 245 245 255))

;; ClearBackground
(define %clear-background
  (foreign-lambda*
      void
      ([int r] [int g] [int b] [int a])
    "ClearBackground((Color){r, g, b, a});"))
(define (clear-background clr)
  (%clear-background (color-r clr) (color-g clr) (color-b clr) (color-a clr)))

;; BeginDrawing
(f begin-drawing
   BeginDrawing
   void)

;; EndDrawing
(f end-drawing
   EndDrawing
   void)

(define-syntax with-drawing
  (er-macro-transformer
   (lambda (e r c)
     (let ([body (cdr e)])
       `(begin
          (begin-drawing)
          ,@body
          (end-drawing))))))

(f set-target-fps
   SetTargetFPS
   void
   int fps)

(f get-frame-time
   GetFrameTime
   float)

(f get-time
   GetTime
   double)

(f get-fps
   GetFPS
   int)
