import AeCont

/-- info: "-42" -/
#guard_msgs in
#eval run "-42"

/-- info: "-9" -/
#guard_msgs in
#eval run "(+ (+) (-) (+ -7) (- 5) (- -3))"

/-- info: "15" -/
#guard_msgs in
#eval run "(saveCont (- 30 (+ 2 3 4) (- 8 3 1) 2))"

/-- info: "15" -/
#guard_msgs in
#eval run "(+ 100 (- 50 (loadCont (+ 7 8)) 3) 200)"

/-- info: "20" -/
#guard_msgs in
#eval run "(saveCont (+ 10 (loadCont 20) (loadCont 30)))"

/-- info: "-7" -/
#guard_msgs in
#eval run "(- (saveCont (- (loadCont 7) (loadCont 11) (loadCont 13))))"

/-- info: "61" -/
#guard_msgs in
#eval run "(- 100 10 (saveCont (+ 1 (loadCont 20) 3)) (- 9 5) (+ 2 3))"

/-- info: "7" -/
#guard_msgs in
#eval run "(saveCont (- 100 (saveCont (+ 1 (loadCont 20) 3)) (loadCont 7) (loadCont 9)))"

/-- info: "307" -/
#guard_msgs in
#eval run "(+ 100 (saveCont (- 50 (loadCont (+ 1 (loadCont 7) (loadCont 9))) 3)) 200)"

/-- info: "307" -/
#guard_msgs in
#eval run "(+ 100 (saveCont (- 50 (loadCont (saveCont (+ 1 (loadCont 7) 3))) 4)) 200)"
