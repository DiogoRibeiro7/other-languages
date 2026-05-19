# Roadmap

This roadmap focuses on turning the repository into a cleaner, more consistent, and easier-to-run multi-language learning project.

## Progress Status

- [x] Added baseline repository documentation (`README.md`).
- [x] Added root ignore rules (`.gitignore`).
- [x] Added contribution guidelines (`CONTRIBUTING.md`).
- [x] Started naming cleanup (`Cataln`/`fibbonacci` -> `Catalan`/`Fibonacci`).
- [ ] Source/build folder split for all language examples.
- [ ] Root-level validation runner for all examples.
- [ ] CI workflow for compile/run checks.

## Phase 1: Foundation (short term)

1. Standardize project naming and structure.
2. Remove or relocate generated binaries and build outputs from source folders.
3. Add per-language quickstart notes where missing.
4. Ensure all examples run with a minimal command from documented paths.

### Tasks

1. Rename typo-prone files/classes (for example `Cataln` -> `Catalan`, `fibbonacci` -> `fibonacci`).
2. Group source files and outputs into clearer subfolders (for example `src/`, `build/`, `bin/` where appropriate).
3. Keep `.gitignore` aligned with generated files across all languages.
4. Add a short `CONTRIBUTING.md` with coding conventions and run expectations.

## Phase 2: Consistency and Quality

1. Add a consistent style baseline per language.
2. Add basic validation commands (build/run checks).
3. Improve code readability and comments for educational value.

### Tasks

1. Add a simple root script or make target to run all runnable examples.
2. Add lightweight formatting/linting guidance:
   - C++: formatting preference
   - Go: `gofmt`
   - JavaScript/TypeScript: formatter/linter setup
   - Java/Fortran: basic style expectations
3. Refactor examples to use consistent naming, input/output style, and file headers.
4. Add small smoke tests or expected-output checks where practical.

## Phase 3: Learning Experience

1. Expand algorithm examples with clear progression from basic to intermediate.
2. Add cross-language equivalents of the same problems.
3. Document complexity and tradeoffs for each implementation.

### Tasks

1. Create an `examples/` index table mapping language -> topic -> file.
2. For each major algorithm (Fibonacci, Catalan, matrix methods), include:
   - iterative and recursive variants (where meaningful)
   - complexity notes
   - sample input/output
3. Add short writeups for language-specific differences.

## Phase 4: Automation and CI

1. Introduce CI for compile/run validation.
2. Prevent regressions for docs and example execution.
3. Publish quality signals in pull requests.

### Tasks

1. Add a GitHub Actions workflow to run language-specific checks.
2. Add a docs check for markdown consistency.
3. Add a PR template with checklist items (builds, docs updated, naming consistency).
4. Add badges to `README.md` once CI is in place.

## Backlog (optional)

1. Containerized dev environment for reproducibility.
2. Benchmark folder for algorithm runtime comparisons.
3. Small CLI menu to run selected examples from one entry point.
4. Versioned learning tracks (beginner/intermediate).

## Definition of Done (per change)

1. Change is documented in README or relevant notes.
2. Example compiles/runs in its language environment.
3. No generated artifacts are newly tracked by git.
4. Naming and folder conventions remain consistent.
