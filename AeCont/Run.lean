import AeCont.Interp
import AeCont.Parser

open AeCont.Parser (parse)

partial def run (code : String) : String :=
  match parse code with
  | .error _ => "parsing failed"
  | .ok e => s!"{interp e (fun v ↦ v) (fun v ↦ v)}"
