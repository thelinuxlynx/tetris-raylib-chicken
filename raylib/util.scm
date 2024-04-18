;; (f internal-name external-name return-type [arg-type arg-name ...])
(define-syntax f
  (er-macro-transformer
   (lambda (e r c)
     (let* ([scheme-name (list-ref e 1)]
            [c-name (symbol->string (list-ref e 2))]
            [internal-name (string->symbol
                            (string-append "%" (symbol->string scheme-name)))]
            [return-type (list-ref e 3)]
            [arglist (cddddr e)]
            [arg-types (do ([lst arglist (cdr lst)]
                            [res '()]
                            [i 0 (add1 i)])
                           ((zero? (length lst)) res)
                         (when (= 0 (modulo i 2))
                           (set! res (append res (list (car lst))))))]
            [arg-names (do ([lst arglist (cdr lst)]
                            [res '()]
                            [i 0 (add1 i)])
                           ((zero? (length lst)) res)
                         (when (= 1 (modulo i 2))
                           (set! res (append res (list (car lst))))))])
       `(begin
          (define ,internal-name
            (foreign-lambda ,return-type ,c-name ,@arg-types))
          (define (,scheme-name ,@arg-names)
            (,internal-name ,@arg-names)))))))
