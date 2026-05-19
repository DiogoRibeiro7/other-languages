# other-languages

Small collection of learning exercises across multiple programming languages.

## Repository layout

- `helloworld/`: C++ console examples
- `fortran/`: Fortran examples
- `helloworldfortran/`: additional Fortran hello-world style examples
- `go/`: Go examples
- `javafolder/`: Java algorithms and snippets
- `javascript/`: JavaScript algorithm snippets
- `typescript/`: browser TypeScript hello-world
- `demo/`: playground folder

## Run examples

### C++

From `helloworld/`:

```powershell
g++ .\helloworld.cpp -o .\helloworld.exe
.\helloworld.exe
```

### Go

From repo root:

```powershell
go run .\go\hello.go
```

### Java

From `javafolder/`:

```powershell
javac .\HelloWorld.java
java HelloWorld
```

For files that depend on JARs in `javafolder\lib`, include classpath:

```powershell
javac -cp ".;.\lib\*" .\SomeFile.java
java -cp ".;.\lib\*" SomeFile
```

### JavaScript

From repo root:

```powershell
node .\javascript\CatalanNumber.js
```

### TypeScript (browser)

From `typescript/`:

```powershell
npx tsc .\app.ts
```

Then open `typescript/index.html` in a browser.

### Fortran

From `fortran/`:

```powershell
gfortran .\circlearea.f95 -o .\circlearea.exe
.\circlearea.exe
```

## Notes

- This repo intentionally keeps simple standalone files for experimentation.
- Some compiled artifacts are currently tracked from earlier work; `.gitignore` prevents adding more build outputs.
