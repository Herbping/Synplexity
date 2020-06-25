type nat =
  | Z
  | S of nat

type list =
  | Nil
  | Cons of nat * list

type tree =
  | Leaf
  | Node of tree * nat * tree

let rec append (l1:list) (l2:list) : list =
  match l1 with
  | Nil u -> l2
  | Cons t -> Cons (#1 t, append (#2 t) l2)
;;

let rec tree_inorder: tree -> list |>
/\( Leaf -> []
, Node (Leaf, 1, Leaf) -> [1]
, Node (Leaf, 2, Leaf) -> [2]
, Node \/((Node (Leaf, 1, Leaf), 2, Leaf)
         ,(Leaf, 1, Node (Leaf, 2, Leaf))) -> [1;2]
) = ?
