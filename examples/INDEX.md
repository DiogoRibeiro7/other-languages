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

- Topic: Fibonacci (fast doubling)
- File: `fortran/fibonacci_fast_doubling.f95`
- Run:
  - `gfortran .\fortran\fibonacci_fast_doubling.f95 -o .\.build\fortran\fibonacci_fast_doubling.exe`
  - `.\.build\fortran\fibonacci_fast_doubling.exe`
- Complexity: O(log n) time, O(log n) recursion depth
- Sample output: contains `fib_fast(92) = 7540113804746346429`

- Topic: LU solve (partial pivoting, Ax=b)
- File: `fortran/lu_solve.f95`
- Run:
  - `gfortran .\fortran\lu_solve.f95 -o .\.build\fortran\lu_solve.exe`
  - `.\.build\fortran\lu_solve.exe`
- Complexity: O(n^3) decomposition, O(n^2) solve
- Sample output: contains `lu_solution = [1.0, -2.0, -2.0]`
- Determinant: `determinant = -3.0`
- Row residuals: each entry in `row_residuals` should be `< 1e-12` in absolute value
- Residual check: `residual_inf_norm` should be `< 1e-12`

- Topic: Dijkstra shortest path (binary heap)
- File: `fortran/dijkstra_heap.f95`
- Run:
  - `gfortran .\fortran\dijkstra_heap.f95 -o .\.build\fortran\dijkstra_heap.exe`
  - `.\.build\fortran\dijkstra_heap.exe`
- Complexity: O((V+E) log V)
- Sample output: contains `dijkstra_dist = [0,7,9,20,20,11]`

- Topic: Bellman-Ford (negative edges)
- File: `fortran/bellman_ford.f95`
- Run:
  - `gfortran .\fortran\bellman_ford.f95 -o .\.build\fortran\bellman_ford.exe`
  - `.\.build\fortran\bellman_ford.exe`
- Complexity: O(VE)
- Sample output: contains `bellman_ford_dist = [0,2,4,7,-2]` and `bellman_ford_neg_cycle = 0`

- Topic: Floyd-Warshall (all-pairs shortest paths)
- File: `fortran/floyd_warshall.f95`
- Run:
  - `gfortran .\fortran\floyd_warshall.f95 -o .\.build\fortran\floyd_warshall.exe`
  - `.\.build\fortran\floyd_warshall.exe`
- Complexity: O(V^3)
- Sample output: contains `floyd_row0 = [0,5,8,9]` and `floyd_row1 = [1000000000,0,3,4]`

- Topic: A* pathfinding (Manhattan heuristic on grid)
- File: `fortran/astar_grid.f95`
- Run:
  - `gfortran .\fortran\astar_grid.f95 -o .\.build\fortran\astar_grid.exe`
  - `.\.build\fortran\astar_grid.exe`
- Complexity: typical O((V+E) log V), heuristic-dependent
- Sample output: contains `astar_path_cost = 9`

- Topic: Johnson APSP (Bellman-Ford reweight + repeated Dijkstra)
- File: `fortran/johnson_apsp.f95`
- Run:
  - `gfortran .\fortran\johnson_apsp.f95 -o .\.build\fortran\johnson_apsp.exe`
  - `.\.build\fortran\johnson_apsp.exe`
- Complexity: O(VE + V(E+V)logV)
- Sample output:
  - `johnson_row0 = [0,2,4,7,-2]`
  - `johnson_row1 = [-2,0,2,5,-4]`
  - `johnson_row3 = [-7,-5,-3,0,-9]`
  - `johnson_neg_cycle = 0`

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

- Topic: Fibonacci (fast doubling)
- File: `c/fibonacci_fast_doubling.c`
- Run:
  - `gcc .\c\fibonacci_fast_doubling.c -o .\.build\c\fibonacci_fast_doubling.exe`
  - `.\.build\c\fibonacci_fast_doubling.exe`
- Complexity: O(log n) time, O(log n) recursion depth
- Sample output: `fib_fast(92) = 7540113804746346429`

- Topic: LU solve (partial pivoting, Ax=b)
- File: `c/lu_solve.c`
- Run:
  - `gcc .\c\lu_solve.c -o .\.build\c\lu_solve.exe`
  - `.\.build\c\lu_solve.exe`
- Complexity: O(n^3) decomposition, O(n^2) solve
- Sample output: `lu_solution = [1.0, -2.0, -2.0]`
- Determinant: `determinant = -3.0`
- Row residuals: each entry in `row_residuals` should be `< 1e-12` in absolute value
- Residual check: `residual_inf_norm` should be `< 1e-12`

- Topic: Dijkstra shortest path (binary heap)
- File: `c/dijkstra_heap.c`
- Run:
  - `gcc .\c\dijkstra_heap.c -o .\.build\c\dijkstra_heap.exe`
  - `.\.build\c\dijkstra_heap.exe`
- Complexity: O((V+E) log V)
- Sample output: `dijkstra_dist = [0,7,9,20,20,11]`

- Topic: Bellman-Ford (negative edges)
- File: `c/bellman_ford.c`
- Run:
  - `gcc .\c\bellman_ford.c -o .\.build\c\bellman_ford.exe`
  - `.\.build\c\bellman_ford.exe`
- Complexity: O(VE)
- Sample output: `bellman_ford_dist = [0,2,4,7,-2]` and `bellman_ford_neg_cycle = 0`

- Topic: Floyd-Warshall (all-pairs shortest paths)
- File: `c/floyd_warshall.c`
- Run:
  - `gcc .\c\floyd_warshall.c -o .\.build\c\floyd_warshall.exe`
  - `.\.build\c\floyd_warshall.exe`
- Complexity: O(V^3)
- Sample output: `floyd_row0 = [0,5,8,9]` and `floyd_row1 = [1000000000,0,3,4]`

- Topic: A* pathfinding (Manhattan heuristic on grid)
- File: `c/astar_grid.c`
- Run:
  - `gcc .\c\astar_grid.c -o .\.build\c\astar_grid.exe`
  - `.\.build\c\astar_grid.exe`
- Complexity: typical O((V+E) log V), heuristic-dependent
- Sample output: `astar_path_cost = 9`

- Topic: Johnson APSP (Bellman-Ford reweight + repeated Dijkstra)
- File: `c/johnson_apsp.c`
- Run:
  - `gcc .\c\johnson_apsp.c -o .\.build\c\johnson_apsp.exe`
  - `.\.build\c\johnson_apsp.exe`
- Complexity: O(VE + V(E+V)logV)
- Sample output:
  - `johnson_row0 = [0,2,4,7,-2]`
  - `johnson_row1 = [-2,0,2,5,-4]`
  - `johnson_row3 = [-7,-5,-3,0,-9]`
  - `johnson_neg_cycle = 0`

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

- Topic: Transactions report (batch validate + aggregate)
- File: `cobol/transactions_report.cob`
- Input: `cobol/sample_transactions.txt`
- Run:
  - `cobc -x .\cobol\transactions_report.cob -o .\.build\cobol\transactions_report.exe`
  - `.\.build\cobol\transactions_report.exe`
- Complexity: O(n) by input records
- Sample output:
  - `TOTAL_RECORDS=00006`
  - `VALID_RECORDS=00004`
  - `INVALID_RECORDS=00002`
  - `DEBIT_TOTAL_CENTS=000000001325`
  - `CREDIT_TOTAL_CENTS=000000001300`
  - `NET_TOTAL_CENTS=+000000000025`

## Expected Outputs (Smoke Checks)

- C hello: `Hello, C world`
- C factorial: `factorial(10) = 3628800`
- C Fibonacci iterative: `fib_iterative(20) = 6765`
- C Fibonacci recursive: `fib_recursive(20) = 6765`
- C Fibonacci fast doubling: `fib_fast(92) = 7540113804746346429`
- C LU solve: `lu_solution = [1.0, -2.0, -2.0]`
- C LU determinant: `determinant = -3.0`
- C LU row residuals: each entry in `row_residuals` should be `< 1e-12`
- C LU residual: `residual_inf_norm` value should be `< 1e-12`
- C Dijkstra heap: `dijkstra_dist = [0,7,9,20,20,11]`
- C Bellman-Ford: `bellman_ford_dist = [0,2,4,7,-2]`, `bellman_ford_neg_cycle = 0`
- C Floyd-Warshall: `floyd_row0 = [0,5,8,9]`, `floyd_row1 = [1000000000,0,3,4]`
- C A*: `astar_path_cost = 9`
- C Johnson APSP: rows match reference APSP and `johnson_neg_cycle = 0`
- COBOL hello: `Hello, COBOL world`
- COBOL factorial: contains `3628800`
- COBOL Fibonacci iterative: contains `6765`
- COBOL transactions report: totals and counts match sample input fixture
- Fortran circle area: contains `The area is`
- Fortran Fibonacci iterative: contains `6765`
- Fortran Fibonacci recursive: contains `6765`
- Fortran Fibonacci fast doubling: contains `7540113804746346429`
- Fortran LU solve: contains `lu_solution = [1.0, -2.0, -2.0]`
- Fortran LU determinant: contains `determinant = -3.0`
- Fortran LU row residuals: each entry in `row_residuals` should be `< 1e-12`
- Fortran LU residual: `residual_inf_norm` value should be `< 1e-12`
- Fortran Dijkstra heap: contains `dijkstra_dist = [0,7,9,20,20,11]`
- Fortran Bellman-Ford: contains `bellman_ford_dist = [0,2,4,7,-2]`, `bellman_ford_neg_cycle = 0`
- Fortran Floyd-Warshall: contains `floyd_row0 = [0,5,8,9]`, `floyd_row1 = [1000000000,0,3,4]`
- Fortran A*: contains `astar_path_cost = 9`
- Fortran Johnson APSP: rows match reference APSP and `johnson_neg_cycle = 0`
