#lang racket

(define (assert-equal msg a b)
  (if (eq? a b)
      (printf "correct: [~a] ~a == ~a" msg a b)
      (error 'wrong "[~a] ~a != ~a" msg a b))
  (newline))

; provide
(provide assert-equal)
