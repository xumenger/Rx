#lang racket

(require (lib "racket/fixnum"))


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

(provide R0?)


; R0 interpreter
(define (interp-R0 p)
  (define (exp ex)
    (match ex
      [(? fixnum?) ex]
      ; if parse (read) call read to get input
      [`(read)
       (let ([r (read)])
         (cond [(fixnum? r) r]
               [else (error 'interp-R0 "input [~a] not an integer" r)]))]
      [`(- ,e)      (fx- 0 (exp e))]
      [`(+ ,e1 ,e2) (fx+ (exp e1) (exp e2))]))
  (match p
    [`(program ,e) (exp e)]))

(provide interp-R0)


; A Partial Evaluator
(define (pe-neg r)
  (cond [(fixnum? r) (fx- 0 r)]
        [else `(- ,r)]))

(define (pe-add r1 r2)
  (cond [(and (fixnum? r1) (fixnum? r2)) (fx+ r1 r2)]
        [else `(+ ,r1 ,r2)]))

(define (pe-arith e)
  (match e
    [(? fixnum?) e]
    [`(read) `(read)]
    [`(- ,(app pe-arith r1))
     (pe-neg r1)]
    [`(+ ,(app pe-arith r1) ,(app pe-arith r2))
     (pe-add r1 r2)]))

(provide pe-arith)