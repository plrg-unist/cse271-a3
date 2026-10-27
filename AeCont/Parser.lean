import Std.Internal.Parsec
import AeCont.Lang

open Std.Internal.Parsec (eof many notFollowedBy satisfy)
open Std.Internal.Parsec.String (Parser digits pchar pstring ws)

namespace AeCont.Parser

def token (p : Parser α) : Parser α := do
  let result ← p
  notFollowedBy (satisfy fun c ↦
    !c.isWhitespace && c != '(' && c != ')')
  ws
  pure result

def int : Parser Int := do
  let negative ← (some <$> pchar '-').orElse fun _ ↦ pure none
  let n := Int.ofNat (← digits)
  pure (if negative.isSome then -n else n)

partial def expr : Parser Expr :=
  (Expr.num <$> token int).orElse fun _ ↦ do
    _ ← pchar '('; ws
    let result ←
      (do
        _ ← token (pchar '+')
        let es ← many expr
        pure (Expr.add es.toList)).orElse fun _ ↦
      (do
        _ ← token (pchar '-')
        let es ← many expr
        pure (Expr.sub es.toList)).orElse fun _ ↦
      (do
        _ ← token (pstring "saveCont")
        Expr.saveCont <$> expr).orElse fun _ ↦ do
        _ ← token (pstring "loadCont")
        Expr.loadCont <$> expr
    _ ← pchar ')'; ws
    pure result

def parse (s : String) : Except String Expr :=
  Parser.run (do
    ws
    let result ← expr
    eof
    pure result) s

end AeCont.Parser
