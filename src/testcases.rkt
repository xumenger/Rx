#lang racket

(require "./R0.rkt")
(require "./unittest.rkt")

; test R0
; exp ::= int | (read) | (- exp) | (+ exp exp)
; R0  ::= (program exp)
(assertequal "(program 8)" (R0? `(program 8)) #t)
(assertequal "(program (read))" (R0? `(program (read))) #t)
(assertequal "(program (- 8))" (R0? `(program (- 8))) #t)
(assertequal "(program (+ 8))" (R0? `(program (+ 8))) #f)
(assertequal "(program (+ 1 1))" (R0? `(program (+ 1 1))) #t)
(assertequal "(program (+ 1 (read)))" (R0? `(program (+ 1 (read)))) #t)
