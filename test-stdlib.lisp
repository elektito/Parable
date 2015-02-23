;; not
(eq (not #t) #f)
(eq (not #f) #t)

;; =
(= #t #t)
(= #f #f)
(= 1 1)
(= 'x 'x)
(= "foo" "foo")
(not (= #t #f))
(not (= #f #t))
(not (= 1 2))
(not (= "foo" "Foo"))
(not (= 'foo "foo"))
(not (= 10 "10"))
(= nil nil)
(= '(1) '(1))
(= '(10 20) '(10 20))
(= '(1 (2 3) 'foo ()) '(1 (2 3) 'foo ()))
(not (= '(1) '(1 2)))

;; list
(= (list) '())
(= (list 1 'x "foo") '(1 x "foo"))

;; null
(eq (null nil) #t)
(eq (null '(1 2 3)) #f)

;; and
(and)
(and #t)
(and #t #t)
(and #t #t #t)
(not (and #t #f #t #t))
(not (and #f))
(not (and #f #t))
(not (and #t #f))
(not (and #f #f))

;; or
(not (or))
(or #t)
(not (or #f))
(or #t #t)
(or #t #t #t #t)
(or #t #t #t #f #t)
(not (or #f #f #f))
(or #t #f)
(or #f #t)
(not (or #f #f))

;; append
(= (append) nil)
(= (append '(1))
   '(1))
(= (append '(1 2) '(3))
   '(1 2 3))
(= (append '(1) '(2 3))
   '(1 2 3))
(= (append '(1 2) '(3) '(4 5))
   '(1 2 3 4 5))
(= (append nil '(1 2) '(3))
   '(1 2 3))
(= (append '(1 2) nil)
   '(1 2))

;; mapf
(= (mapf null '(1 2 '(1) () '(x y)))
   (list #f #f #f #t #f))
(= (mapf first '((1 2) (x y) ("foo" 10 20)))
   '(1 x "foo"))

;; remove-if
(= (remove-if null '(1 2 () 3 (x y)))
   '(1 2 3 (x y)))
(= (remove-if null nil)
   nil)

;; second
(= (second '(1 2 3)) 2)

;; ffirst
(= (ffirst '((1 2) 3 4))
   1)

;; rfirst
(= (rfirst '((1 2) 3 4))
   '(2))

;; last
(= (last '(1 2 3))
   3)
(= (last '(:foo))
   :foo)
(= (last nil)
   :#ERROR#:)
(= (last 1)
   :#ERROR#:)

;; firsts
(= (firsts '((1 2 3) (x y z)))
   '(1 x))

(= (firsts '((1 2 3)))
   '(1))

(= (firsts nil) nil)

;; rests
(= (rests '((1 2 3) (x y z)))
   '((2 3) (y z)))

(= (rests '((1 2 3)))
   '((2 3)))

(= (rests nil) nil)

;; any
(not (any nil))
(any (list #f #f #f #t #f))
(any (list #t))
(not (any (list #f)))
(not (any (list #f #f #f)))

;; all
(all nil)
(all (list #t #t #t #t))
(not (all (list #f)))
(not (all (list #f #f #t #f)))
(not (all (list #t #t #f #t)))

;; zip
(= (zip) nil)
(= (zip nil nil nil) nil)
(= (zip '(1))
   '((1)))
(= (zip '(1 2) '(a b) '("foo" "bar"))
   '((1 a "foo") (2 b "bar")))

;; let
(let ((x 2)
      (y 'foo)
      (z "bar"))
  (and (= x 2)
       (= y 'foo)
       (= z "bar")))

;; let*
(let* ((x 10))
  (= x 10))
(let* ((x 2)
      (y x))
  (= y 2))

;; cond
(not (cond))
(= 100
   (cond (#t 100)
         (#t 200)))
(= 200
   (cond (#f 100)
         (#t 200)))
(= 400
   (cond (#f 100)
         (#f 200)
         (#f 300)
         (#t 400)))

;; when
(= 100
   (when #t
     100))
(= nil
   (when #f
     100))

;; atom
(atom 'x)
(atom 10)
(atom "foo")
(not (atom nil))
(not (atom '(1)))
(not (atom '(1 2 3)))

;; map
(let ((foo (fn (x y) (list y x))))
  (= (map foo '(10 20) '(foo bar))
     '((foo 10) (bar 20))))
(= (map (fn () 10)) nil)

;; eval
(= (eval 1) 1)
(= (eval ''foo) 'foo)
(= (eval "foo") "foo")
(= (eq 'foo 'foo) #t)
(= (eval '(if #f (list 1) (list 2)))
   '(2))
(= (eval '(let ((x 10)) x))
   10)

;; assoc
(= (assoc :foo '(:foo 10 :bar 20 :buz 30))
   10)
(= (assoc :bar '(:foo 10 :bar 20 :buz 30))
   20)
(= (assoc :buz '(:foo 10 :bar 20 :buz 30))
   30)
(= (assoc :spam '(:foo 10 :bar 20 :buz 30))
   :#ERROR-NOT-FOUND#:)
(= (assoc :spam nil)
   :#ERROR-NOT-FOUND#:)
(= (assoc :foo '(:foo))
   :#ERROR-INVALID#:)
(= (assoc :foo :foo)
   :#ERROR-INVALID#:)
