;;Data format: Name, Mother, Father, Date of birth, Date of death.
;;An empty list means Unknown.

;;Maternal branch
(define Mb
'(((Mary Blake) ((Ana Ali) (Theo Blake)) ((17 9 2022) ()))
((Ana Ali) ((Ada West) (Md Ali)) ((4 10 1995) ()))
((Theo Blake) ((Mary Jones) (Tom Blake)) ((9 5 1997) ()))
((Greta Blake) ((Mary Jones) (Tom Blake)) ((16 3 1999) ()))
((Mary Jones) (() ())((12 5 1967) (19 5 2024)))
((Tom Blake) (() ()) ((17 1 1964) ()))
((Ada West) (() ()) ((22 8 1973) ()))
((Md Ali) (() ()) ((14 2 1972) (2 5 2023)))
((Ned Bloom) (() ()) ((23 04 2001)()))
((John Bloom) ((Greta Blake) (Ned Bloom)) ((5 12 2023) ()))))

;,Paternal branch
(define Pb
'(((John Smith) ((Jane Doe) (Fred Smith)) ((1 12 1956) (3 3 2021))) 
((Ana Smith) ((Jane Doe) (Fred Smith)) ((6 10 1958) ()))
((Jane Doe) ((Eve Talis) (John Doe)) ((2 6 1930) (4 12 1992)))
((Fred Smith) ((Lisa Brown) (Tom Smith)) ((17 2 1928) (13 9 2016)))
((Eve Talis) (() ()) ((15 5 1900) (19 7 1978)))
((John Doe) (() ()) ((18 2 1899)(7 7 1970)))
((Lisa Brown) (() ())((31 6 1904) (6 3 1980)))
((Tom Smith) (() ()) ((2 8 1897) (26 11 1987)))
((Alan Doe) ((Eve Talis) (John Doe)) ((8 9 1932) (23 12 2000)))
((Mary Doe) (() (Alan Doe)) ((14 4 1964) ()))))

;;define lst-mb
;;define lst-pb
;;define lst-all

;; C1
(define (lst-mb mb)
  (if (null? mb) '() ;; base case
        (cons (caar mb)
        (lst-mb (cdr mb))))) ;; recursively get all member from the branch
 
;; C2
(define (lst-pb pb)
  (if (null? pb) '() ;; base case
        (cons (caar pb)
        (lst-pb (cdr pb))))) ;; recursively get all member from the branch
                    
;; C3
(define (append-lst list1 list2)
        (if (null? list1) list2
            (cons (car list1) (append-lst (cdr list1) list2))))
			
(define (lst-all mb pb)
  (append-lst 
    (map car mb)  
    (map car pb))) ;; using map extract members for both branches

;; ----------------Roman Lupuliak - Partner A ---------------------

;; this function takes a person's record and returns their last name
;; as a string. We extract it from the person's name list and convert it
;; from a symbol to a string so that we can compare names easily.
(define (last-name person)
  (symbol->string (cadr (car person))))

;; function to remove-duplicates 
(define (remove-duplicates lst)
  (foldr (lambda (x acc)
           (if (member x acc) acc (cons x acc)))
         '()
         lst))

;; A1: List of All Parents
;; This function goes through the entire family tree (list of records) and extracts the lists of parents from each record.
;; It then merges all these lists into one and removes any duplicate entries.
(define (parents lst)
  (remove-duplicates (apply append (map cadr lst))))
  
;; A2: List of Living Members. This function filters the family tree list and returns only those
;; records where the death date list is empty.
(define (living-members lst)
  (filter (lambda (person)
            (null? (cadr (caddr person))))
          lst))
  
;; A3: This function calculates a person's age based on their date of birth.
;; It uses a current date  for the calculation.
;; If the person hasn't had their birthday yet this year, it subtracts one from the age.
(define (calculate-age dob)
  (let* ((year (car dob))
         (month (cadr dob))
         (day (caddr dob))
         (current-year 2025)
         (current-month 3)
         (current-day 1))
    (if (or (< current-month month)
            (and (= current-month month) (< current-day day)))
        (- current-year year 1)
        (- current-year year))))
  
;; This function applies the calculate-age function to each living member.
;;It returns a list of pairs, where each pair contains the person's name and their current age.
(define (current-age lst)
  (map (lambda (person)
         (list (car person) (calculate-age (car (caddr person)))))
       (living-members lst)))


;; A4: This function finds and returns all the people whose birthday is in the month
;; specified by the user. It extracts the month from each person's birth date and compares it.
(define (same-birthday-month lst month)
  (filter (lambda (person)
            (= month (cadr (car (caddr person)))))
          lst))
  
;; A5:  This section contains two functions:
;; 1. insert - A helper function that takes a person and an already sorted list,
;;      then inserts the person into the correct position based on their last name.
;; 2. sort-by-last - Uses recursion to sort the entire list by repeatedly inserting the first element
;;      of the unsorted list into the sorted list.
(define (insert x lst)
  (if (null? lst)
      (list x)
      (if (string<? (last-name x) (last-name (car lst)))
          (cons x lst)
          (cons (car lst) (insert x (cdr lst))))))

(define (sort-by-last lst)
  (if (null? lst)
      '()
      (insert (car lst) (sort-by-last (cdr lst)))))
  
;; A6: Change a Person's First Name. This function goes through the family tree and changes the first name of a person
;; if it matches the old name provided by the user. It leaves the last name unchanged.
(define (change-name lst old-name new-name)
  (map (lambda (person)
         (if (equal? (car (car person)) old-name)
             (cons (list new-name (cadr (car person))) (cdr person))
             person))
       lst))


;;         --------------------Nazar Levchuk - Partner B -------------------------
;; B1
(define (children lst)
  ;; map over filtered list to get children from the branch
  (map car (filter (λ (family-member)  
                 ;; checking if either of parents exist
                 (or (not (null? (caadr family-member)))
                      (not (null? (cadr (cadr family-member))))))
               lst))) ;; iterate through each member in the branch

;; B2
;; tail-recursive function to find oldest member
(define (oldest-living-member lst)
  ;; auxiliary function to find older member
 (define (aux-oldest-living-member members acc)
  (if (null? members) acc ;; base case
      (aux-oldest-living-member
       (cdr members) ;; go to next member 
       (if (or (< (caddr (car (caddr (car members)))) (caddr (car (caddr acc))))  ;; compare birth years
               (and (= (caddr (car (caddr (car members)))) (caddr (car (caddr acc))))
                    (< (cadr (car (caddr (car members)))) (cadr (car (caddr acc))))) ;;compare birth months
               (and (= (caddr (car (caddr (car members)))) (caddr (car (caddr acc))))
                    (= (cadr (car (caddr (car members)))) (cadr (car (caddr acc))))
                    (< (caar (caddr (car members))) (caar (caddr acc))))) ;; compare birth days
           (car members) 
           acc))))
  
  ;; function to filter living members
  (define filtered-living
    (filter (λ (member) (null? (cadr (caddr member)))) lst))
  (if (null? filtered-living) '()
      ;; return oldest living member if found
      (car (aux-oldest-living-member (cdr filtered-living) (car filtered-living)))))
  
;; B3
(define (average-age-on-death lst)
  (define (get-death-ages person)
    (if (null? (cadr (caddr person))) #f
        (- (car (reverse (cadr (caddr person)))) ;; get death year
           (car (reverse (car (caddr person)))))))  ; get birth year
  
   ;; function to filter death ages
  (define death-ages (filter (λ (age) age) (map get-death-ages lst))) 
  (if (null? death-ages) 0
      ;; get average age at death
      (exact->inexact (/ (foldr + 0 death-ages) (length death-ages))))) 
                                                                                                                                                                                 
;; B4
;; (month 5 has been used to check this, as my month is not in the tree)
(define (birthday-month-same lst month)
  ;; filter members with the same bith month and then extract their names using map
  (map car (filter (λ (member) (= (cadr (caaddr member)) month)) lst))) 

;; B5
(define (sort-by-first lst)
  (if (null? lst) '() ;; base case
      ;; sort the list recursively 
      (append (sort-by-first (filter (λ (member)
                                       ;; converting symbol to string and comparing 2 strings
                                       (string<? (symbol->string (caar member))
                                                 (symbol->string (car (caar lst)))))
                                     (cdr lst))) ;; process on the rest of list
              (list (caar lst)) ;; pivot
              ;; same process for names before pivot
              (sort-by-first (filter (λ (member) 
                                       (string>=? (symbol->string (caar member)) 
                                                  (symbol->string (car (caar lst))))) 
                                     (cdr lst))))))

;; B6
(define (change-name-to-Maria lst old-name new-name)
  (cond
    ((null? lst) lst) ;; base case 
    ((not (list? lst))  ;; check for list
     (if (equal? lst old-name) new-name lst))  ;; replace if matches input name
    (else  ;; recrusively proccess each element 
     (map (λ (x) (change-name-to-Maria x old-name new-name)) lst))))

;;
;;You should include code to execute each of your functions below.
;;       ---------------  Roman and Nazar - C1 to C3  ----------------------
;; C1
(display "C1:\n")
(display "All members in the Maternal Branch:\n")
(lst-pb Mb)
(newline)

;; C2
(display "C2:\n")
(display "All members in the Paternal Branch:\n")
(lst-pb Pb)
(newline)

;; C3
(display "C3:\n")
(display "All members in both branches:\n")
(lst-all Mb Pb)
(newline)

;;     ----------------Roman Lupuliak - Partner A ---------------------
;; A1-A6
(display "A1 to A6 Functions - Roman Lupuliak\n")
(newline)

;; A1: all the parents in the branch
(display "A1: List of All Parents (Maternal branch):\n")
(parents Mb)
(newline)

;; A2: all living members of the branch 
(display "A2: Living Members (Maternal branch):\n")
(living-members Mb)
(newline)

;; A3: Curret age 
(display "A3: Current Ages of Living Members (Maternal branch):\n")
(current-age Mb)
(newline)

;; A4: People with birtday in May (5)
(display "A4: People with Birthday in May (Maternal branch):\n")
(same-birthday-month Mb 5)
(newline)

;; A5: Sort by Surname
(display "A5: Sorted by Last Name (Maternal branch):\n")
(sort-by-last Mb)
(newline)


;; A6: Change name from Mary to Maria
(display "A6: Change First Name from Mary to Maria (Maternal branch):\n")
(change-name Mb 'John 'Juan)
(newline)
(newline)

;   --------------------Nazar Levchuk - Partner B -------------------------
(display "B1 to B6 Functions - Nazar Levchuk\n")
;; B1
(display "B1: children\n")
;;(display "Maternal branch:\n")
;;(children Mb)
;;(newline)
(display "Paternal branch:\n")
(children Pb)
(newline)

;; B2
(display "B2: oldest living member\n")
;;(display "Maternal branch:\n")
;;(oldest-living-member Mb)
;;(newline)
(display "Paternal branch:\n")
(oldest-living-member Pb)
(newline)

;; B3
(display "B3: average age on death\n")
;;(display "Maternal branch:\n")
;;(average-age-on-death Mb)
;;(newline)
(display "Paternal branch:\n")
(average-age-on-death Pb)
(newline)

;; B4
(display "B4: same birth month\n")
;;(display "Maternal branch:\n")
;;(birthday-month-same Mb 5)
;;(newline)
(display "Paternal branch:\n")
(birthday-month-same Pb 5)
(newline)

;; B5
(display "B5: sort by fisrt name\n")
;;(display "Maternal branch:\n")
;;(sort-by-first Mb)
;;(newline)
(display "Paternal branch:\n")
(sort-by-first Pb)
(newline)

;; B6
(display "B6: change name to Maria\n")
;;(display "Change name to Maria in Maternal branch:\n")
;;(change-name-to-Maria Mb 'Mary 'Maria)
;;(newline)
(display "Change name to Maria in Paternal branch:\n")
(change-name-to-Maria Pb 'Mary 'Maria)
(newline)
