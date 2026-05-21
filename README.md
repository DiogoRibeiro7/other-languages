# other-languages

[![CI](https://github.com/DiogoRibeiro7/other-languages/actions/workflows/ci.yml/badge.svg)](https://github.com/DiogoRibeiro7/other-languages/actions/workflows/ci.yml)

Small collection of learning exercises across multiple programming languages.

Style and contribution rules:

- `CONTRIBUTING.md`
- `STYLE_GUIDE.md`
- `examples/INDEX.md`
- `examples/LANGUAGE_NOTES.md`

## Primary Focus

Current primary focus languages:

- Fortran
- C
- COBOL

## Repository layout

- `helloworld/`: C++ console examples
- `c/`: C examples (hello world and factorial)
- `cobol/`: COBOL examples (hello world and factorial)
- `fortran/`: Fortran examples
- `helloworldfortran/`: additional Fortran hello-world style examples
- `go/`: Go examples
- `javafolder/`: Java algorithms and snippets
- `javascript/`: JavaScript algorithm snippets
- `typescript/`: browser TypeScript hello-world
- `demo/`: playground folder

## Run examples

## Smoke check (all languages)

From repo root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run-all.ps1
```

The script runs available toolchains and marks missing ones as skipped.
Fortran, C, and COBOL checks include basic expected-output validation.

### C++

From `helloworld/`:

```powershell
New-Item -ItemType Directory -Force -Path ..\.build\cpp | Out-Null
g++ .\helloworld.cpp -o ..\.build\cpp\helloworld.exe
..\.build\cpp\helloworld.exe
```

### C

From repo root:

```powershell
New-Item -ItemType Directory -Force -Path .\.build\c | Out-Null
gcc .\c\hello.c -o .\.build\c\hello.exe
.\.build\c\hello.exe

gcc .\c\factorial.c -o .\.build\c\factorial.exe
.\.build\c\factorial.exe
```

### COBOL

From repo root (GNU COBOL / `cobc`):

```powershell
New-Item -ItemType Directory -Force -Path .\.build\cobol | Out-Null
cobc -x .\cobol\hello.cob -o .\.build\cobol\hello.exe
.\.build\cobol\hello.exe

cobc -x .\cobol\factorial.cob -o .\.build\cobol\factorial.exe
.\.build\cobol\factorial.exe
```

### Go

From repo root:

```powershell
go run .\go\hello.go
```

### Java

From `javafolder/`:

```powershell
New-Item -ItemType Directory -Force -Path ..\.build\java | Out-Null
javac -d ..\.build\java .\HelloWorld.java
java -cp ..\.build\java HelloWorld
```

For files that depend on JARs in `javafolder\lib`, include classpath:

```powershell
javac -cp ".;.\lib\*" -d ..\.build\java .\SomeFile.java
java -cp "..\.build\java;.\lib\*" SomeFile
```

### JavaScript

From repo root:

```powershell
node .\javascript\CatalanNumber.js
```

### TypeScript (browser)

From `typescript/`:

```powershell
tsc .\app.ts --outDir ..\.build\typescript
```

Then open `typescript/index.html` in a browser.

### Fortran

From `fortran/`:

```powershell
New-Item -ItemType Directory -Force -Path ..\.build\fortran | Out-Null
gfortran .\circlearea.f95 -o ..\.build\fortran\circlearea.exe
..\.build\fortran\circlearea.exe
```

## Notes

- This repo intentionally keeps simple standalone files for experimentation.
- Some compiled artifacts are currently tracked from earlier work; `.gitignore` prevents adding more build outputs.
