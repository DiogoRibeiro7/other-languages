# Style Guide

This repository favors simple, readable examples over heavy framework setup.

## General

1. Use descriptive, correctly spelled names for files, classes, and functions.
2. Keep examples small and focused on one concept.
3. Avoid generated artifacts in source folders; use `.build/` outputs.

## C++

1. Prefer `clang-format` style consistency when available.
2. Use clear includes, avoid unused headers, and keep `main` examples compact.

## Go

1. Run `gofmt -w` on changed `.go` files.
2. Keep package structure simple for standalone examples.

## Java

1. Match `public class` name to the file name.
2. Follow standard Java naming: `PascalCase` classes, `camelCase` methods/variables.
3. Keep external dependency usage explicit in compile/run commands.

## JavaScript

1. Prefer `const` by default; use `let` only when reassignment is needed.
2. Keep algorithm output deterministic and easy to read.

## TypeScript

1. Use explicit types for public-facing variables and function parameters where helpful.
2. Compile outputs should go to `.build/typescript`.

## Fortran

1. Keep program units concise and include clear input/output prompts.
2. Use consistent indentation for readability.

## Quick local checks

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run-all.ps1
gofmt -w .\go\hello.go
npx --yes markdownlint-cli2 "**/*.md"
```
