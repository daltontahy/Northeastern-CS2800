#lang lsl

#|
CS2800 - Logic & Computation

Comprhensive Recap, Racket Logical Student Language

This file will serve as a comprhensive recap of all major ideas, structs, and topics leading up to and slightly beyond exam 1.
Many concepts included in here have orginated from CS2500, but have been carried over due to the structure of LSL. My hope with
this is to shine some light on important parts of this language that can get overlooked in the problem solving nature of homework
assignments, and can be misrepresented in lectures. I hope to shine light on what makes this language function, and how it can
continue to be used in the future
|#



;; Part 1: Function Syntax, Contracts

; in LSL, functions are defined as they are in ISL+. that goes...

(define (myFunction x y z)
  ...)

; we can also define "variables", as well as structures


(define-struct color [name])

; A Color is one of:
;  - "red"
;  - "blue"
;  - "green"
;  - "yellow"
;  - "purple"
(define RED "red")
(define BLUE "blue")
(define GREEN "green")
(define YELLOW "yellow")
(define PURPLE "purple")
(define ALL-COLORS (list RED BLUE GREEN YELLOW PURPLE))

; notice how these have the comment before explaining what they are? these are necessary
; for intrepreting what the vars represent and how functions will handle them. the function
; should have a purpose statment too, declaring what it does. the contract is useful for
; making sure it gives the right things, but we still need to intrepret what its giving us.


; now, what is a contract? In ISL+ we add a contract to our functions to specify which types of data will
; be returned. this is like how java requires a return type on all function definitions,
; except we have to add it ourselves. we are essentially removing flexibility from a flexible language

; it will look something like this:

(: myFunction (-> Boolean Boolean Boolean Boolean))

; notice how there are 4 "parameters"? that is because the last one represents the return type.
; LSL is equiped to understand that myFunction has 3 parameters, therefore it will expect the
; contract to contain 4 types. Some pre-defined types in LSL include Natural, Integer, Boolean,
; True, False, (List Integer), (List Natural), etc etc etc.


; HOWEVER, we are not just limited to these values. we can also define a contract for a function
; that takes another arbitrary function as a parameter. that would look like this

(: doubleFunction (-> (List Integer) (-> Integer Integer) Boolean))

; in this contract, it is stated that the function doubleFunction will take in a list of integers and
; another function, that of which will take in an integer and return an integer, and then doubleFunction
; will return a boolean. the function that will be taken in by the higher order one can be defined normally
; as it would be on its own. this language doesn't have many restrictions as to what you can pass as parameters.


;; ** CHECKING THESE CONTRACTS **

; we can easily check these contracts by using the built in feature "check-contract". what this will essentially
; do is pass many randomly generated inputs into the given program, and check to see if it adheres to the
; specifications that were set by the contract. going back to the myFunction example:

(check-contract myFunction)

; what this will do is pass many different combinations of booleans into my function, and check to see if the
; function returns the expected value, a boolean, on all occasions.



;; PART 1.1: Immediate, Dependent, and Custom Contracts

; now that we can make contracts and check them, its only intutitive for the next step to be about how we make
; custom contracts. that is, a contract that can check for conditions not intutitive to the programming language.

; the first two things we need to understand are "Immediate" and how it ties into dependednt contracts. Lets make
; an example that represents a contract that checks if an inputed number is greater than another.

(define-contract (GreaterThan x y)
  (Immediate (lambda (y) (> y x))))

; in this example, Immediate is telling racket to check if these predicates hold certian values. they are not complex,
; and they do not check any complex conditions outside of whether, for example, y is greater than x.

; now, lets say we want to define a function given as:

(define (max a b)
  (if (> a b) a b))

; and we want to create a contract for this function using our greater than contract. it would end up looking like this:

(: max (Function (arguments [a Number] [b Number])
                 (result (AllOf Number (GreaterThan a) (GreaterThan b)))))

; the syntax here is pretty straightforward. what it is saying is that arguments a and b are both numbers, and max should
; return something that satisfies "AllOf" the conditions of it being a Number, GreaterThan a, and GreaterThan b. its kinda
; tricky to wrap your head around the first time, but it becomes more clear as you continue programming in concrete examples.

; On a less complicated note, we can create more simple contracts for distinct values. these values don't always need to meet
; a certian condition, rather the contract just defines a new arbritary type of data. for example:

(define-contract Bit (OneOf (Constant 0) (Constant 1)))

; additionally, we can create recursive data. for a tree, we would do -

(define-contract (Tree X) (OneOf (Leaf X) (Node (Tree X) (Tree X))))

; This essentially shows us that we can recursively refer to our new data in the same way we could if we used a (define-struct).


;; what about more general cases?

; we can use the keyword "All" to make general functions


