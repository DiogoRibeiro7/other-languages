Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$buildRoot = Join-Path $repoRoot ".build"
$failed = 0
$passed = 0
$skipped = 0

function Has-Command {
    param([string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Step-Pass {
    param([string]$Name)
    Write-Host "[PASS] $Name" -ForegroundColor Green
    $script:passed++
}

function Step-Skip {
    param([string]$Name, [string]$Reason)
    Write-Host "[SKIP] $Name - $Reason" -ForegroundColor Yellow
    $script:skipped++
}

function Step-Fail {
    param([string]$Name, [string]$Reason)
    Write-Host "[FAIL] $Name - $Reason" -ForegroundColor Red
    $script:failed++
}

function Run-Step {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    try {
        & $Action
        if ($LASTEXITCODE -ne 0) {
            throw "Command exited with code $LASTEXITCODE"
        }
        Step-Pass -Name $Name
    } catch {
        Step-Fail -Name $Name -Reason $_.Exception.Message
    }
}

function Assert-ResidualBelow {
    param(
        [string]$Text,
        [double]$Tolerance,
        [string]$Label
    )
    $match = [regex]::Match($Text, "residual_inf_norm\s*=\s*([0-9]+\.[0-9]+[eE][\+\-][0-9]+)")
    if (-not $match.Success) {
        throw "Missing residual output for ${Label}: $Text"
    }
    $value = [double]::Parse($match.Groups[1].Value, [System.Globalization.CultureInfo]::InvariantCulture)
    if ([math]::Abs($value) -ge $Tolerance) {
        throw "Residual too large for ${Label}: $value (tolerance $Tolerance)"
    }
}

Write-Host "Running multi-language smoke checks from $repoRoot"
New-Item -ItemType Directory -Path $buildRoot -Force | Out-Null

if (Has-Command "gcc") {
    Run-Step "C hello compile and run" {
        $cBuild = Join-Path $buildRoot "c"
        New-Item -ItemType Directory -Path $cBuild -Force | Out-Null
        $out = Join-Path $cBuild "hello.exe"
        gcc (Join-Path $repoRoot "c\hello.c") -o $out
        $result = & $out
        if ($result -notmatch "Hello, C world") {
            throw "Unexpected C hello output: $result"
        }
    }
    Run-Step "C factorial compile and run" {
        $cBuild = Join-Path $buildRoot "c"
        New-Item -ItemType Directory -Path $cBuild -Force | Out-Null
        $out = Join-Path $cBuild "factorial.exe"
        gcc (Join-Path $repoRoot "c\factorial.c") -o $out
        $result = & $out
        if ($result -notmatch "factorial\(10\) = 3628800") {
            throw "Unexpected C factorial output: $result"
        }
    }
    Run-Step "C Fibonacci iterative compile and run" {
        $cBuild = Join-Path $buildRoot "c"
        New-Item -ItemType Directory -Path $cBuild -Force | Out-Null
        $out = Join-Path $cBuild "fibonacci_iterative.exe"
        gcc (Join-Path $repoRoot "c\fibonacci_iterative.c") -o $out
        $result = & $out
        if ($result -notmatch "fib_iterative\(20\) = 6765") {
            throw "Unexpected C Fibonacci iterative output: $result"
        }
    }
    Run-Step "C Fibonacci recursive compile and run" {
        $cBuild = Join-Path $buildRoot "c"
        New-Item -ItemType Directory -Path $cBuild -Force | Out-Null
        $out = Join-Path $cBuild "fibonacci_recursive.exe"
        gcc (Join-Path $repoRoot "c\fibonacci_recursive.c") -o $out
        $result = & $out
        if ($result -notmatch "fib_recursive\(20\) = 6765") {
            throw "Unexpected C Fibonacci recursive output: $result"
        }
    }
    Run-Step "C LU solve compile and run" {
        $cBuild = Join-Path $buildRoot "c"
        New-Item -ItemType Directory -Path $cBuild -Force | Out-Null
        $out = Join-Path $cBuild "lu_solve.exe"
        gcc (Join-Path $repoRoot "c\lu_solve.c") -o $out
        $result = & $out
        $text = ($result | Out-String)
        if ($text -notmatch "lu_solution = \[1.0, -2.0, -2.0\]") {
            throw "Unexpected C LU output: $text"
        }
        Assert-ResidualBelow -Text $text -Tolerance 1.0e-12 -Label "C LU"
    }
} else {
    Step-Skip "C checks" "gcc not found"
}

if (Has-Command "go") {
    Run-Step "Go hello" {
        go run (Join-Path $repoRoot "go\hello.go") | Out-Null
    }
} else {
    Step-Skip "Go hello" "go not found"
}

if (Has-Command "node") {
    Run-Step "JavaScript Catalan" {
        node (Join-Path $repoRoot "javascript\CatalanNumber.js") | Out-Null
    }
} else {
    Step-Skip "JavaScript Catalan" "node not found"
}

if (Has-Command "javac" -and Has-Command "java") {
    Run-Step "Java compile" {
        $javaBuild = Join-Path $buildRoot "java"
        New-Item -ItemType Directory -Path $javaBuild -Force | Out-Null
        Push-Location $repoRoot
        try {
            javac -d $javaBuild .\javafolder\HelloWorld.java .\javafolder\CatalanNumber.java .\javafolder\Fibonacci.java
        } finally {
            Pop-Location
        }
    }
    Run-Step "Java run HelloWorld" {
        $javaBuild = Join-Path $buildRoot "java"
        java -cp $javaBuild HelloWorld | Out-Null
    }
} else {
    Step-Skip "Java checks" "javac/java not found"
}

if (Has-Command "g++") {
    Run-Step "C++ compile and run" {
        $cppBuild = Join-Path $buildRoot "cpp"
        New-Item -ItemType Directory -Path $cppBuild -Force | Out-Null
        $out = Join-Path $cppBuild "helloworld.exe"
        g++ (Join-Path $repoRoot "helloworld\helloworld.cpp") -o $out
        & $out | Out-Null
    }
} else {
    Step-Skip "C++ compile and run" "g++ not found"
}

if (Has-Command "gfortran") {
    Run-Step "Fortran compile" {
        $fortranBuild = Join-Path $buildRoot "fortran"
        New-Item -ItemType Directory -Path $fortranBuild -Force | Out-Null
        $out = Join-Path $fortranBuild "circlearea.exe"
        gfortran (Join-Path $repoRoot "fortran\circlearea.f95") -o $out
    }
    Run-Step "Fortran run" {
        $fortranBuild = Join-Path $buildRoot "fortran"
        $out = Join-Path $fortranBuild "circlearea.exe"
        $result = cmd /c "echo 2|`"$out`""
        $text = ($result | Out-String)
        if ($text -notmatch "The area is") {
            throw "Unexpected Fortran output: $text"
        }
    }
    Run-Step "Fortran Fibonacci iterative compile and run" {
        $fortranBuild = Join-Path $buildRoot "fortran"
        $out = Join-Path $fortranBuild "fibonacci_iterative.exe"
        gfortran (Join-Path $repoRoot "fortran\fibonacci_iterative.f95") -o $out
        $result = & $out
        $text = ($result | Out-String)
        if ($text -notmatch "6765") {
            throw "Unexpected Fortran Fibonacci iterative output: $text"
        }
    }
    Run-Step "Fortran Fibonacci recursive compile and run" {
        $fortranBuild = Join-Path $buildRoot "fortran"
        $out = Join-Path $fortranBuild "fibonacci_recursive.exe"
        gfortran (Join-Path $repoRoot "fortran\fibonacci_recursive.f95") -o $out
        $result = & $out
        $text = ($result | Out-String)
        if ($text -notmatch "6765") {
            throw "Unexpected Fortran Fibonacci recursive output: $text"
        }
    }
    Run-Step "Fortran LU solve compile and run" {
        $fortranBuild = Join-Path $buildRoot "fortran"
        $out = Join-Path $fortranBuild "lu_solve.exe"
        gfortran (Join-Path $repoRoot "fortran\lu_solve.f95") -o $out
        $result = & $out
        $text = ($result | Out-String)
        if ($text -notmatch "lu_solution = \[\s*1.0,\s*-2.0,\s*-2.0\]") {
            throw "Unexpected Fortran LU output: $text"
        }
        Assert-ResidualBelow -Text $text -Tolerance 1.0e-12 -Label "Fortran LU"
    }
} else {
    Step-Skip "Fortran compile" "gfortran not found"
}

if (Has-Command "cobc") {
    $cobolBuild = Join-Path $buildRoot "cobol"
    New-Item -ItemType Directory -Path $cobolBuild -Force | Out-Null
    $cobolUsable = $true

    try {
        cobc -x (Join-Path $repoRoot "cobol\hello.cob") -o (Join-Path $cobolBuild "hello.exe") 2>$null
        if ($LASTEXITCODE -ne 0) {
            $cobolUsable = $false
        }
    } catch {
        $cobolUsable = $false
    }

    if (-not $cobolUsable) {
        Step-Skip "COBOL checks" "cobc found but toolchain is not usable on this machine"
    } else {
        Run-Step "COBOL hello run" {
            $out = Join-Path $cobolBuild "hello.exe"
            $result = & $out
            if ($result -notmatch "Hello, COBOL world") {
                throw "Unexpected COBOL hello output: $result"
            }
        }
        Run-Step "COBOL factorial compile and run" {
            $out = Join-Path $cobolBuild "factorial.exe"
            cobc -x (Join-Path $repoRoot "cobol\factorial.cob") -o $out
            $result = & $out
            if ($result -notmatch "3628800") {
                throw "Unexpected COBOL factorial output: $result"
            }
        }
    }
} else {
    Step-Skip "COBOL checks" "cobc not found"
}

if (Has-Command "tsc") {
    Run-Step "TypeScript compile" {
        $tsBuild = Join-Path $buildRoot "typescript"
        New-Item -ItemType Directory -Path $tsBuild -Force | Out-Null
        Push-Location $repoRoot
        try {
            tsc .\typescript\app.ts --outDir $tsBuild
        } finally {
            Pop-Location
        }
    }
} else {
    Step-Skip "TypeScript compile" "tsc not found"
}

Write-Host ""
Write-Host "Summary: $passed passed, $skipped skipped, $failed failed."
if ($failed -gt 0) {
    exit 1
}
