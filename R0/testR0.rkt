#lang racket

(require "./R0.rkt")
(require "../test/unittest.rkt")

; test R0
; exp ::= int | (read) | (- exp) | (+ exp exp)
; R0  ::= (program exp)
(assert-equal "(program 8)" (R0? `(program 8)) #t)
(assert-equal "(program (read))" (R0? `(program (read))) #t)
(assert-equal "(program (- 8))" (R0? `(program (- 8))) #t)
(assert-equal "(program (+ 8))" (R0? `(program (+ 8))) #f)
(assert-equal "(program (+ 1 1))" (R0? `(program (+ 1 1))) #t)
(assert-equal "(program (+ 1 (read)))" (R0? `(program (+ 1 (read)))) #t)
(assert-equal "(program (program 3))" (R0? `(program (program 3))) #f)


; test interp-R0
(interp-R0 `(program (+ 1 (+ (read) (- 8)))))


; test evaluator
(assert-equal "(pe-arith 1)" (pe-arith 1) 1)
(assert-equal "(pe-arith (+ 1 1))" (pe-arith (+ 1 1)) 2)
(assert-equal "(pe-arith (+ 1 1))" (pe-arith (+ 1 (- 3))) -2)
(pe-arith (+ (read) (+ (- 3) (+ 10 (read)))))