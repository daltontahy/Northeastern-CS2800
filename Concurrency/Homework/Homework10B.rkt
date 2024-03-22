#lang lsl

;; Problem 1
;; Define the state for the "a" process

;; part p1
(define-contract AState False)
;; part p1

;; Problem 2
;; Define handlers for the "a" process

;; part p2
(: a-start (-> (List String) (Action AState)))
(define (a-start others)
  (action #f (list (send-packet "b" "hello"))))



(test-suite
 "a-start"
 (check-expect (a-start
                (list "b" "c"))
               (action #f (list (send-packet "b" "hello"))))
 (check-contract a-start))


(: a-receive (-> AState (ReceivePacket String) (Action AState)))
(define (a-receive st pkt)
  (cond
     ((and (string=? (receive-packet-from pkt) "c") (string=? (receive-packet-msg pkt) "got it")) (action #f (list (send-packet "b" "hello"))))
     (else
      (action #f (list)))))



(test-suite
 "a-receive"
  (check-expect (a-receive #f (receive-packet "c" "got it")) (action #f (list (send-packet "b" "hello"))))
  (check-contract a-receive))



;; part p2

;; Problem 3
;; Define state for the "b" process

;; part p3
(define-contract BState False)
;; part p3

;; Problem 4
;; Define handlers for the "b" process

;; part p4
(: b-start (-> (List String) (Action BState)))
;(define (b-start others)
;  (action #f (list (send-packet "c" "hello"))))
(define (b-start others)

  (action #f (list)))


(test-suite
 "b-start"
 (check-expect (b-start
                (list "a" "c"))
               (action #f (list)))
 (check-contract b-start))
               

(: b-receive (-> BState (ReceivePacket String) (Action BState)))
(define (b-receive st pkt)
    (cond
     ((and (string=? (receive-packet-from pkt) "a") (string=? (receive-packet-msg pkt) "hello")) (action #f (list (send-packet "c" "hello"))))
     (else
      (action #f (list)))))


(test-suite
 "b-receive"
 (check-expect (b-receive #f (receive-packet "a" "hello")) (action #f (list (send-packet "c" "hello"))))
 (check-contract b-receive))

;; part p4

;; Problem 5
;; Define state for the "c" process

;; part p5
(define-contract CState (List String))
;; part p5

;; Problem 6
;; Define handlers for the "c" process

;; part p6
(: c-start (-> (List String) (Action CState)))
(define (c-start others)
  (action empty (list)))


(test-suite
 "c-start"
 (check-expect (c-start (list "a" "b")) (action empty (list)))
 (check-contract c-start))


(: c-receive (-> CState (ReceivePacket String) (Action CState)))
(define (c-receive st pkt)
    (cond
     ((<= 4 (length st))
     (action st (list)))
     ((and (string=? (receive-packet-from pkt) "b") (string=? (receive-packet-msg pkt) "hello")) (action (cons (receive-packet-msg pkt) st) (list (send-packet "a" "got it"))))
     (else
     (action empty (list)))))


(test-suite
 "c-receive"
 (check-expect (c-receive (list "hello" "hello" "hello") (receive-packet "b" "hello")) (action (list "hello" "hello" "hello" "hello") (list (send-packet "a" "got it"))))
 (check-expect (c-receive (list "hello" "hello" "hello" "hello") (receive-packet "b" "hello")) (action (list "hello" "hello" "hello" "hello") (list)))
 (check-contract c-receive))


;; part p6

;; Problem 7
;; Define all the processes using the handlers above:

;; part p7
(define a-process (process (name "a")
                           (on-start a-start)
                           (on-receive a-receive)))
                                 
(define b-process (process (name "b")
                           (on-start b-start)
                           (on-receive b-receive)))
  
(define c-process (process (name "c")
                           (on-start c-start)
                           (on-receive c-receive)))

;; part p7

;; Problem 8
;;
;; Define two functions, main and main-debug, that run the program using start
;; and start-debug respectively. You can use `first` as the scheduler for both.

;; part p8

(define (random-ref l)
  (list-ref l (random (length l))))

(define (main)
  (start
   first
   (list a-process b-process c-process)))

(define (main-debug)
  (start-debug first (list a-process b-process c-process)))

(main-debug)

;(define (main) 
;    (second
;     (assoc "a"
;           (start-debug random-ref
;                 (list a-process
;                       b-process
;                       c-process)))))

;(main)
;; part p8
