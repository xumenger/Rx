#lang racket

; BNF
; exp ::= int | (read) | (- exp) | (+ exp exp)
; R0  ::= (program exp)
(define (R0? sexp)
  (define (exp? ex)
    (match ex
      [(? fixnum?) #t]
      [`(read) #t]
      [`(- ,e) (exp? e)]
      [`(+ ,e1 ,e2)
        (and (exp? e1) (exp? e2))]
      [else #f]))
  (match sexp
    [`(program ,e) (exp? e)]
    [else #f]))

; proview
(provide R0?)