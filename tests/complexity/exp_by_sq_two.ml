type nat =
  | Z
  | S of nat

type list =
  | Nil
  | Cons of nat * list

