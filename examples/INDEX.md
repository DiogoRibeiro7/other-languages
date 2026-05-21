# Examples Index

Primary track: Fortran, C, COBOL.

## Fortran

- Topic: Circle area (interactive input)
- File: `fortran/circlearea.f95`
- Run:
  - `gfortran .\fortran\circlearea.f95 -o .\.build\fortran\circlearea.exe`
  - `echo 2 | .\.build\fortran\circlearea.exe`
- Complexity: O(1)
- Sample output: contains `The area is`

- Topic: Fibonacci (iterative)
- File: `fortran/fibonacci_iterative.f95`
- Run:
  - `gfortran .\fortran\fibonacci_iterative.f95 -o .\.build\fortran\fibonacci_iterative.exe`
  - `.\.build\fortran\fibonacci_iterative.exe`
- Complexity: O(n) time, O(1) extra space
- Sample output: contains `fib_iterative(          20 ) =         6765`

- Topic: Fibonacci (recursive)
- File: `fortran/fibonacci_recursive.f95`
- Run:
  - `gfortran .\fortran\fibonacci_recursive.f95 -o .\.build\fortran\fibonacci_recursive.exe`
  - `.\.build\fortran\fibonacci_recursive.exe`
- Complexity: O(2^n) time, O(n) call stack
- Sample output: contains `fib_recursive(          20 ) =         6765`

- Topic: LU solve (partial pivoting, Ax=b)
- File: `fortran/lu_solve.f95`
- Run:
  - `gfortran .\fortran\lu_solve.f95 -o .\.build\fortran\lu_solve.exe`
  - `.\.build\fortran\lu_solve.exe`
- Complexity: O(n^3) decomposition, O(n^2) solve
- Sample output: contains `lu_solution = [1.0, -2.0, -2.0]`
- Residual check: `residual_inf_norm` should be `< 1e-12`

## C

- Topic: Hello world
- File: `c/hello.c`
- Run:
  - `gcc .\c\hello.c -o .\.build\c\hello.exe`
  - `.\.build\c\hello.exe`

- Topic: Factorial (iterative)
- File: `c/factorial.c`
- Run:
  - `gcc .\c\factorial.c -o .\.build\c\factorial.exe`
  - `.\.build\c\factorial.exe`
- Complexity: O(n) time, O(1) extra space
- Sample output: `factorial(10) = 3628800`

- Topic: Fibonacci (iterative)
- File: `c/fibonacci_iterative.c`
- Run:
  - `gcc .\c\fibonacci_iterative.c -o .\.build\c\fibonacci_iterative.exe`
  - `.\.build\c\fibonacci_iterative.exe`
- Complexity: O(n) time, O(1) extra space
- Sample output: `fib_iterative(20) = 6765`

- Topic: Fibonacci (recursive)
- File: `c/fibonacci_recursive.c`
- Run:
  - `gcc .\c\fibonacci_recursive.c -o .\.build\c\fibonacci_recursive.exe`
  - `.\.build\c\fibonacci_recursive.exe`
- Complexity: O(2^n) time, O(n) call stack
- Sample output: `fib_recursive(20) = 6765`

- Topic: LU solve (partial pivoting, Ax=b)
- File: `c/lu_solve.c`
- Run:
  - `gcc .\c\lu_solve.c -o .\.build\c\lu_solve.exe`
  - `.\.build\c\lu_solve.exe`
- Complexity: O(n^3) decomposition, O(n^2) solve
- Sample output: `lu_solution = [1.0, -2.0, -2.0]`
- Residual check: `residual_inf_norm` should be `< 1e-12`

## COBOL

- Topic: Hello world
- File: `cobol/hello.cob`
- Run:
  - `cobc -x .\cobol\hello.cob -o .\.build\cobol\hello.exe`
  - `.\.build\cobol\hello.exe`

- Topic: Factorial (iterative)
- File: `cobol/factorial.cob`
- Run:
  - `cobc -x .\cobol\factorial.cob -o .\.build\cobol\factorial.exe`
  - `.\.build\cobol\factorial.exe`
- Complexity: O(n) time, O(1) extra space
- Sample output: contains `3628800`

- Topic: Fibonacci (iterative)
- File: `cobol/fibonacci_iterative.cob`
- Run:
  - `cobc -x .\cobol\fibonacci_iterative.cob -o .\.build\cobol\fibonacci_iterative.exe`
  - `.\.build\cobol\fibonacci_iterative.exe`
- Complexity: O(n) time, O(1) extra space
- Sample output: contains `6765`
- Note: recursive COBOL Fibonacci is intentionally omitted for now due to portability/toolchain differences.

## Expected Outputs (Smoke Checks)

- C hello: `Hello, C world`
- C factorial: `factorial(10) = 3628800`
- C Fibonacci iterative: `fib_iterative(20) = 6765`
- C Fibonacci recursive: `fib_recursive(20) = 6765`
- C LU solve: `lu_solution = [1.0, -2.0, -2.0]`
- C LU residual: `residual_inf_norm` value should be `< 1e-12`
- COBOL hello: `Hello, COBOL world`
- COBOL factorial: contains `3628800`
- COBOL Fibonacci iterative: contains `6765`
- Fortran circle area: contains `The area is`
- Fortran Fibonacci iterative: contains `6765`
- Fortran Fibonacci recursive: contains `6765`
- Fortran LU solve: contains `lu_solution = [1.0, -2.0, -2.0]`
- Fortran LU residual: `residual_inf_norm` value should be `< 1e-12`
