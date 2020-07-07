type nat =
  | Z
  | S of nat

type list =
  | Nil
  | Cons of nat * list

type bool =
  | True
  | False

let rec add (n1:nat) (n2:nat) : nat =
  match n1 with
  | Z u -> n2
  | S n1 -> S (add n1 n2)
;; 

let rec mult (n1:nat) (n2:nat) : nat |*| (0,0,1)  =
  match n1 with
  | Z u -> Z
  | S n3 -> add n2 (mult n3 n2)
;; 



let bnot (n:bool) : bool =
    match n with
      | True u  -> False
      | False u -> True
;; 

let rec even (n:nat) : bool =
    match n with
      | Z u  -> True
      | S m  -> bnot (even m)
;; 

let rec exp_two : nat -> nat |*| (0,1,0) |>
 /\(0 -> 1,
     1 -> 2,
     2 -> 4,
     3 -> 8,
     4 -> 16) = ? 
