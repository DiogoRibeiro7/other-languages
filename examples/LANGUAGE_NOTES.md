# Language Notes

Short comparison notes for the current primary languages: Fortran, C, and COBOL.

## Numerical Work (Fortran vs C)

- Fortran is concise for numeric code:
  - Native array syntax and clear scientific formatting.
  - Good fit for matrix algorithms like LU decomposition.
- C is explicit and low-level:
  - Full control over memory layout and loops.
  - Good fit when you need predictable, portable systems behavior.

Tradeoff summary:

- Fortran usually gives faster readability for math-heavy routines.
- C usually gives finer control and easier integration with systems tooling.

## Algorithm Style (Iterative vs Recursive)

- C and Fortran both show iterative and recursive Fibonacci implementations.
- Iterative versions are practical defaults:
  - O(n) time, O(1) extra space.
- Recursive versions are educational:
  - O(2^n) time, O(n) call stack.

Rule of thumb:

- Use recursive examples to explain recurrence relations.
- Use iterative versions for production-like runs and benchmarks.

## Matrix Solve Reliability

- Both C and Fortran LU examples use partial pivoting.
- Both compute a residual infinity norm (`||Ax-b||_inf`) after solving.
- Smoke checks enforce a residual tolerance (`< 1e-12`) instead of exact zero.

Why this matters:

- Floating-point arithmetic introduces tiny rounding error.
- Tolerance-based checks are the correct way to validate numeric correctness.

## COBOL Fit in This Repo

- COBOL examples focus on deterministic, business-style batch logic:
  - clear procedural flow
  - fixed numeric fields
  - predictable text output
- Current COBOL track is iterative only (factorial and Fibonacci) for portability.

Tradeoff summary:

- COBOL is strong for explicit record/process/report style workflows.
- It is less ergonomic for recursive or matrix-heavy scientific algorithms.

## Where to go next

1. Add a COBOL mini-batch pipeline (read, validate, aggregate, report).
2. Add C and Fortran benchmark timing around Fibonacci and LU.
3. Add LU determinant and residual-per-row reporting to deepen numeric diagnostics.
