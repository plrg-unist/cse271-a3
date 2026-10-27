# CSE271 Principles of Programming Languages — Assignment 3: Multi-Operand Arithmetic

## Overview

In this assignment, you will extend the AE-Cont language from the lecture to support addition and subtraction with any number of operands. You will implement an interpreter in continuation-passing style (CPS), including a function that evaluates a list of expressions.

## Getting the Code and Running

### Clone

```bash
git clone https://github.com/plrg-unist/cse271-a3.git
cd cse271-a3
```

### Running the Tests

This assignment requires [Lake](https://lean-lang.org/install/). Run the provided test cases with:

```bash
lake test
```

### Running the Interpreter

Run the interpreter with:

```bash
lake exec ae-cont
```

Enter an AE-Cont expression, then send end-of-file (for example, Ctrl-D on macOS or Linux). The interpreter reads all input as one expression and prints the result. Running it is not required to complete the assignment, but trying diverse inputs is recommended to validate your implementation.

## What You Need to Read

Only these three files are required reading:

- `AeCont/Lang.lean`: Defines expressions.
- `AeCont/Interp.lean`: Contains the interpreter logic you will complete.
- `Tests.lean`: Contains the provided test cases.

The following files are provided but do not need to be read:

- `AeCont/Parser.lean`: Parses AE-Cont source text into expressions.
- `AeCont/Run.lean`: Connects parsing and interpretation and formats results.
- `AeCont.lean`: Imports the library modules.
- `Main.lean`: Reads standard input and prints the interpreter result.

## What You May Change

- You are expected to change `AeCont/Interp.lean`, replacing each `sorry` with a proper implementation.
- You may modify the provided templates or introduce helper definitions, but you must preserve the signature of `interp`.
- `AeCont/Interp.lean` is the only file you will submit.
- You may add your own test cases to `Tests.lean`, but you will not submit this file.

## Language

### Concrete Syntax

You may refer to this syntax when adding your own test cases or writing input for the interpreter.

```text
<expr> ::= <int>
         | "(" "+" <expr-list> ")"
         | "(" "-" <expr-list> ")"
         | "(" "saveCont" <expr> ")"
         | "(" "loadCont" <expr> ")"
<expr-list> ::= "" | <expr> <expr-list>
```

### Abstract Syntax

$$
\begin{aligned}
e ::= {}& n
  \mid \texttt{(+}\ e\ \cdots\ e\texttt{)}
  \mid \texttt{(-}\ e\ \cdots\ e\texttt{)}
  \mid \texttt{(saveCont}\ e\texttt{)}
  \mid \texttt{(loadCont}\ e\texttt{)}
\end{aligned}
$$

Here, $n$ is an integer. The operand sequences of addition and subtraction may be empty.

### Semantics

Expression results are integers. Evaluation uses a current continuation and a saved continuation, both initially the identity continuation.

- An integer literal produces that integer and continues with the current continuation.
- Addition and subtraction evaluate their operands from left to right, using the same saved continuation for each operand. Their results are collected in the original operand order. If all operands finish normally, the arithmetic result is passed to the current continuation.
- Addition returns the sum of the operand results. With no operands, `(+)` returns `0`; with one operand, it returns that operand's result.
- Subtraction with no operands, `(-)`, returns `0`. With one operand, it negates that operand's result. With two or more operands, it starts with the first result and subtracts each subsequent result from left to right. For example, `(- 10 3 2)` returns `5`.
- `(saveCont e)` saves the current continuation and evaluates `e`.
- `(loadCont e)` replaces the current continuation with the saved continuation before evaluating `e`.

## Understanding the Tests

Each test case records an expected result and checks it against the result of evaluating an expression. For example:

```lean
/-- info: "20" -/
#guard_msgs in
#eval run "(saveCont (+ 10 (loadCont 20) (loadCont 30)))"
```

`run` parses AE-Cont source, evaluates it with identity continuations, and returns the result as a string. It returns `"parsing failed"` if parsing fails. In this example, it returns `"20"` because the first `loadCont` resumes the saved continuation, skipping both the addition and the later `loadCont`.

This test has three parts:

- `/-- info: "20" -/` specifies the expected message.
- `#guard_msgs in` checks that the following command produces exactly that message.
- `#eval run "..."` evaluates the program and reports the returned string.

If every test succeeds, `lake test` completes successfully. If a test fails, it displays error messages describing the discrepancy between the expected and actual messages. You are encouraged to add your own test cases to `Tests.lean`.

## Grading

### Grading Policy

- If your submitted code does not compile, you will receive a score of zero.
- Otherwise, your score is proportional to the number of test cases it passes. The grading test cases may differ from the provided ones.
- Late submission is prohibited.

### Academic Integrity

- Do not get help from other people for solving this assignment.
- Do not give your solution to other people.
- Do not upload your solution to any public repository.
- Any cheating results in an **F** grade.

### LLM Usage

- While you are allowed to use LLMs, you are encouraged not to rely on them.
- Try to tackle the assignment on your own, using LLMs, for example, to understand concepts, get hints, and check your work.
- The provided `AGENTS.md` and `CLAUDE.md` files instruct agents to act as educational assistants. You may launch an agent in the project directory and use it for this purpose.
