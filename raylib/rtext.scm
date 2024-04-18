;; DrawText
(define %draw-text
  (foreign-lambda*
      void
      ([(const c-string) text] [int posX] [int posY] [int fontSize] [int r] [int g] [int b] [int a])
    "DrawText(text, posX, posY, fontSize, (Color){r, g, b, a});"))
(define (draw-text text pos-x pos-y font-size clr)
  (%draw-text text pos-x pos-y font-size (color-r clr) (color-g clr) (color-b clr) (color-a clr)))
