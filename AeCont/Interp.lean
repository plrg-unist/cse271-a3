import AeCont.Lang

/-- Add the integers, returning `0` for an empty list. -/
def addMult (ns : List Int) : Int :=
  match ns with
  | [] => 0
  | n :: ns' => n + addMult ns'

/-- Return `0` for no operands, negate one operand, or subtract the rest from the first. -/
def subMult (ns : List Int) : Int :=
  match ns with
  | [] => 0
  | [n] => -n
  | n :: ns' => n - addMult ns'

mutual

  /--
  Evaluate expressions from left to right with the same saved continuation.
  Pass their integer results to `k` in the original order.
  -/
  def interpMult (es : List Expr) (saved : Int → Int)
      (k : List Int → Int) : Int :=
    match es with
    | [] => sorry
    | e :: es' => sorry

  /-- Evaluate an expression with saved and current continuations. -/
  def interp (e : Expr) (saved k : Int → Int) : Int :=
    match e with
    | .num n => k n
    | .add es => sorry
    | .sub es => sorry
    | .saveCont e => interp e k k
    | .loadCont e => interp e saved saved

end
