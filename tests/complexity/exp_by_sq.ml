type nat =
  | Z
  | S of nat

type list =
  | Nil
  | Cons of nat * list

let rec exp_two : nat -> nat |>
 /\(0 -> 1,
     1 -> 2,
     2 -> 4,
     3 -> 8,
     4 -> 16) = ? || (0,1)
