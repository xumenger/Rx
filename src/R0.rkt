#lang racket

(define (leaf? arith)
  (match arith
    [(? fixnum?) #t]
    ['(read) #t]
    ['(- ,c1) #f]
    ['(+ ,c1 ,c2) #f]))
