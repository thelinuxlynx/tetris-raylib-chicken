(import (chicken syntax))
(import srfi-69
        (only srfi-1 list-tabulate))

(define updater-add)
(define drawer-add)
(define updater-remove)
(define drawer-remove)
(define run-updaters)
(define run-drawers)
(let ([updaters (make-hash-table)]
      [drawers (make-hash-table)]
      [last-updater-key 0]
      [last-drawer-keys (make-hash-table)])
  (set! updater-add
    (lambda (callback)
      (let ([key last-updater-key])
        (hash-table-set! updaters key callback)
        (set! last-updater-key (add1 last-updater-key))
        key)))
  (set! drawer-add
    (lambda (callback #!optional [layer 0])
      (unless (hash-table-exists? drawers layer)
        (hash-table-set! drawers layer (make-hash-table))
        (hash-table-set! last-drawer-keys layer 0))
      (let ([key (hash-table-ref last-drawer-keys layer)])
        (hash-table-set! (hash-table-ref drawers layer) key callback)
        (hash-table-set! last-drawer-keys layer (add1 key))
        (list layer key))))
  (set! updater-remove
    (lambda (id)
      (hash-table-delete! updaters id)))
  (set! drawer-remove
    (lambda (id)
      (hash-table-delete! (hash-table-ref drawers (list-ref id 0)) (list-ref id 1))))
  (set! run-updaters
    (lambda (dt)
      (list-tabulate last-updater-key
                     (lambda (id)
                       (when (hash-table-exists? updaters id)
                         ((hash-table-ref updaters id) dt))))))
  (set! run-drawers
    (lambda (dt)
      (hash-table-for-each
       last-drawer-keys
       (lambda (layer last-key)
         (list-tabulate last-key
                        (lambda (id)
                          (when (hash-table-exists? (hash-table-ref drawers layer) id)
                            ((hash-table-ref (hash-table-ref drawers layer) id) dt)))))))))
