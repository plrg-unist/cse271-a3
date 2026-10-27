inductive Expr where
  | num (n : Int)
  | add (es : List Expr)
  | sub (es : List Expr)
  | saveCont (e : Expr)
  | loadCont (e : Expr)
