#lang racket

(define (assertequal a b)
  (if (eq? a b)
      (printf "correct!")
      (error 'wrong! "~a != ~a" a b)))