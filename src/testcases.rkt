#lang racket

(require "./R0.rkt")
(require "./unittest.rkt")

; test R0
; exp ::= int | (read) | (- exp) | (+ exp exp)
; R0  ::= (program exp)
(assertequal "fixnum" (R0? `(program 8)) #t)
(assertequal "(read)" (R0? `(program (read))) #t)
(assertequal "(read)" (R0? `(program (- 8))) #t)
(assertequal "(read)" (R0? `(program (+ 1 1))) #t)
(assertequal "(read)" (R0? `(program (+ 1 (read)))) #t)
