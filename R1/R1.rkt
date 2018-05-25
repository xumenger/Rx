#lang racket

; https://course.ccs.neu.edu/cs2500f14/code/interp.rkt
; https://github.com/jeapostrophe/jeapostrophe.github.com/tree/master/courses/2017/spring/406/notes/
; https://www.scheme.com/
; https://blog.csdn.net/chinazhangyong/article/details/79331825

(require (lib "racket/fixnum"))
(require (lib "racket/local"))


; Look up the variable's value in the environment
(define (lookup env var)
  (cond [(empty? env) (error 'lookup "Variable is not bound: ~a" var)]
        ; env is a list, contains a lot of (key value) pair, pair is a special list
        [else (local [(define b (first env))]
                ; (car list) used to get first element from list
                ; (cdr list) used to get rest elemets from list except first element
                (cond [(symbol=? (car b) var)
                       (cdr b)]
                      [else (lookup (rest env) var)]))]))


; R1's BNF
; exp ::= int | (read) | (-exp) | (+ exp exp) | var | (let ([var exp]) exp)
; R1  ::= (program exp)
(define (interp-R1 env)
  (lambda (e)
    (define recur (interp-R1 env))
    (match e
      [(? symbol?) (lookup e env)]
      [`(let ([,x ,(app recur v)]) ,body)
       (define new-env (cons (cons x v) env))
       ((interp-R1 new-env) body)]
      [(? fixnum?) e]
      [`(read)
       (define r (read))
       (cond [(fixnum? r) r]
             [else (error 'interp-R1 "expected an integer, not [~a]" r)])]
      [`(- ,(app recur v))
       (fx- 0 v)]
      [`(+ ,(app recur v1) ,(app recur v2))
       (fx+ v1 v2)]
      [`(program ,e) ((interp-R1 `()) e)]
      )))

(provide interp-R1)
