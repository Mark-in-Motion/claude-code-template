@echo off
setlocal EnableDelayedExpansion

REM claude-code-template setup script (Windows)
REM Replaces {{PLACEHOLDER}} tokens with your project details.
REM
REM Usage:
REM   scripts\setup.bat             (interactive setup)
REM   scripts\setup.bat --dry-run   (preview substitutions without changing files)

set "DRY_RUN=false"
if "%~1"=="--dry-run" set "DRY_RUN=true"

goto :main

REM ============================================================
REM Subroutines
REM ============================================================

:prompt_with_default
set "prompt_text=%~1"
set "default_value=%~2"
set "result_var=%~3"

if not "!default_value!"=="" (
    set /p "user_input=!prompt_text! [!default_value!]: "
) else (
    set /p "user_input=!prompt_text!: "
)

if "!user_input!"=="" (
    if not "!default_value!"=="" set "!result_var!=!default_value!"
) else (
    set "!result_var!=!user_input!"
)
goto :eof

:replace_placeholders
set "file=%~1"
if not exist "!file!" goto :eof

if "!DRY_RUN!"=="true" (
    powershell -Command ^
        "$f = '!file!'; " ^
        "$c = [System.IO.File]::ReadAllText($f); " ^
        "$matches = [System.Text.RegularExpressions.Regex]::Matches($c, '\{\{[^}]+\}\}'); " ^
        "if ($matches.Count -gt 0) { Write-Host ('  [preview] ' + $f + ':'); $matches | Select-Object -ExpandProperty Value -Unique | ForEach-Object { Write-Host ('    ' + $_) } } else { Write-Host ('  [preview] ' + $f + ': no placeholders') }"
    goto :eof
)

powershell -Command ^
    "$f = '!file!'; " ^
    "$c = [System.IO.File]::ReadAllText($f); " ^
    "$c = $c.Replace('{{PROJECT_NAME}}', '!PROJECT_NAME!'); " ^
    "$c = $c.Replace('{{DESCRIPTION}}', '!DESCRIPTION!'); " ^
    "$c = $c.Replace('{{PROJECT_DESCRIPTION}}', '!PROJECT_DESCRIPTION!'); " ^
    "$c = $c.Replace('{{PROJECT_TYPE}}', '!PROJECT_TYPE!'); " ^
    "$c = $c.Replace('{{TECH_STACK}}', '!TECH_STACK!'); " ^
    "$c = $c.Replace('{{DATE}}', '!CURRENT_DATE!'); " ^
    "$c = $c.Replace('{{AUTHOR_NAME}}', '!AUTHOR_NAME!'); " ^
    "$c = $c.Replace('{{PROJECT_KEYWORDS}}', '!PROJECT_KEYWORDS!'); " ^
    "$c = $c.Replace('{{REPOSITORY_URL}}', '!REPOSITORY_URL!'); " ^
    "$c = $c.Replace('{{PROGRAMMING_LANGUAGE}}', '!PROGRAMMING_LANGUAGE!'); " ^
    "$c = $c.Replace('{{PRIMARY_LANGUAGE}}', '!PROGRAMMING_LANGUAGE!'); " ^
    "$c = $c.Replace('{{FRAMEWORK}}', '!FRAMEWORK!'); " ^
    "$c = $c.Replace('{{DATABASE}}', '!DATABASE!'); " ^
    "$c = $c.Replace('{{DEPLOYMENT_PLATFORM}}', '!DEPLOYMENT_PLATFORM!'); " ^
    "$c = $c.Replace('{{BUILD_COMMAND}}', '!BUILD_COMMAND!'); " ^
    "$c = $c.Replace('{{START_COMMAND}}', '!START_COMMAND!'); " ^
    "$c = $c.Replace('{{TEST_COMMAND}}', '!TEST_COMMAND!'); " ^
    "$c = $c.Replace('{{LINT_COMMAND}}', '!LINT_COMMAND!'); " ^
    "$c = $c.Replace('{{TEAM_SIZE}}', '!TEAM_SIZE!'); " ^
    "[System.IO.File]::WriteAllText($f, $c)"
echo   Updated !file!
goto :eof

:validate_placeholders
echo.
echo Validating placeholder substitution...
set "unfilled_count=0"
for %%F in (!FILES_LIST!) do (
    if exist "%%F" (
        powershell -Command ^
            "$f = '%%F'; " ^
            "$c = [System.IO.File]::ReadAllText($f); " ^
            "if ($c -match '\{\{[^}]+\}\}') { Write-Host ('  WARNING: Unfilled placeholders in ' + $f) }"
    )
)
echo   Validation complete
goto :eof

REM ============================================================
REM Main
REM ============================================================
:main
echo.
echo AI-Assisted Project Template Setup
echo =====================================
if "!DRY_RUN!"=="true" echo [DRY RUN] No files will be changed - showing preview only
echo.

REM Get current date
for /f %%I in ('powershell -Command "Get-Date -Format yyyy-MM-dd"') do set CURRENT_DATE=%%I

echo Please provide your project information:
echo.

call :prompt_with_default "Project Name" "my-project" PROJECT_NAME
call :prompt_with_default "Short Description (one-liner tagline)" "A project built with claude-code-template" PROJECT_DESCRIPTION
call :prompt_with_default "Full Description" "!PROJECT_DESCRIPTION!" DESCRIPTION

echo.
echo Project type:
echo   1^) Web App
echo   2^) API Service
echo   3^) CLI Tool
echo   4^) Data Pipeline
echo   5^) General
set /p "type_choice=Choose [1-5, default 5]: "
if "!type_choice!"=="1" set "PROJECT_TYPE=Web App"
if "!type_choice!"=="2" set "PROJECT_TYPE=API Service"
if "!type_choice!"=="3" set "PROJECT_TYPE=CLI Tool"
if "!type_choice!"=="4" set "PROJECT_TYPE=Data Pipeline"
if not defined PROJECT_TYPE set "PROJECT_TYPE=General"
if "!type_choice!"=="" set "PROJECT_TYPE=General"

echo.
echo Team size:
echo   1^) Solo
echo   2^) Small team ^(2-5^)
echo   3^) Team ^(6+^)
set /p "team_choice=Choose [1-3, default 1]: "
if "!team_choice!"=="2" (set "TEAM_SIZE=small team") else if "!team_choice!"=="3" (set "TEAM_SIZE=team") else (set "TEAM_SIZE=solo")

call :prompt_with_default "Tech Stack (e.g., Node.js, Python, React)" "Node.js" TECH_STACK
call :prompt_with_default "Programming Language" "JavaScript" PROGRAMMING_LANGUAGE
call :prompt_with_default "Framework" "Express.js" FRAMEWORK
call :prompt_with_default "Database" "PostgreSQL" DATABASE
call :prompt_with_default "Deployment Platform" "Vercel" DEPLOYMENT_PLATFORM
call :prompt_with_default "Author Name" "Your Name" AUTHOR_NAME
call :prompt_with_default "Project Keywords (comma-separated)" "ai-assisted,development,template" PROJECT_KEYWORDS
call :prompt_with_default "Repository URL" "https://github.com/username/repo-name" REPOSITORY_URL

REM Tech stack specific commands
set "USE_TYPESCRIPT=false"
if /i "!TECH_STACK!"=="Node.js" goto :nodejs_setup
if /i "!TECH_STACK!"=="node" goto :nodejs_setup
if /i "!TECH_STACK!"=="nodejs" goto :nodejs_setup
if /i "!TECH_STACK!"=="Python" goto :python_setup
if /i "!TECH_STACK!"=="python" goto :python_setup
if /i "!TECH_STACK!"=="Go" goto :go_setup
if /i "!TECH_STACK!"=="go" goto :go_setup
if /i "!TECH_STACK!"=="golang" goto :go_setup
if /i "!TECH_STACK!"=="Rust" goto :rust_setup
if /i "!TECH_STACK!"=="rust" goto :rust_setup
goto :custom_setup

:nodejs_setup
set /p "ts_choice=Use TypeScript? (y/N): "
if /i "!ts_choice!"=="y" (
    set "USE_TYPESCRIPT=true"
    set "PROGRAMMING_LANGUAGE=TypeScript"
    set "BUILD_COMMAND=tsc"
    set "START_COMMAND=node --watch --experimental-strip-types src/index.ts"
) else (
    set "BUILD_COMMAND=npm run build"
    set "START_COMMAND=node --watch src/index.js"
)
set "TEST_COMMAND=npm test"
set "LINT_COMMAND=npm run lint"
goto :continue_setup

:python_setup
set "BUILD_COMMAND=pip install -e ."
set "START_COMMAND=python app.py"
set "TEST_COMMAND=python -m pytest"
set "LINT_COMMAND=python -m ruff check ."
goto :continue_setup

:go_setup
set "BUILD_COMMAND=go build"
set "START_COMMAND=go run main.go"
set "TEST_COMMAND=go test ./..."
set "LINT_COMMAND=go fmt ./..."
goto :continue_setup

:rust_setup
set "BUILD_COMMAND=cargo build"
set "START_COMMAND=cargo run"
set "TEST_COMMAND=cargo test"
set "LINT_COMMAND=cargo clippy"
goto :continue_setup

:custom_setup
call :prompt_with_default "Build Command" "make build" BUILD_COMMAND
call :prompt_with_default "Start Command" "make start" START_COMMAND
call :prompt_with_default "Test Command" "make test" TEST_COMMAND
call :prompt_with_default "Lint Command" "make lint" LINT_COMMAND

:continue_setup
set "FILES_LIST=CLAUDE.md README.md package.json docs\PROJECT_CONTEXT.md docs\CURRENT_STATUS.md docs\ACTIVE_ROADMAP.md docs\ONBOARDING.md docs\sessions\latest-session.md"

if "!DRY_RUN!"=="true" (
    echo.
    echo Preview of substitutions:
    echo.
    for %%F in (!FILES_LIST!) do call :replace_placeholders "%%F"
    echo.
    echo Dry run complete. No files were changed.
    echo Run without --dry-run to apply.
    goto :done
)

echo.
echo Updating project files...
echo.

for %%F in (!FILES_LIST!) do call :replace_placeholders "%%F"

call :validate_placeholders

REM Handle Node.js
if /i "!TECH_STACK!"=="Node.js" goto :keep_package
if /i "!TECH_STACK!"=="node" goto :keep_package
if /i "!TECH_STACK!"=="nodejs" goto :keep_package

echo.
echo Non-Node.js project.
set /p "keep_package=  Keep package.json? (y/N): "
if /i not "!keep_package!"=="y" (
    del package.json >nul 2>&1
    echo   Removed package.json
)
goto :check_python

:keep_package
echo.
echo Node.js project. Keeping package.json.

:check_python
if /i "!TECH_STACK!"=="Python" goto :keep_requirements
if /i "!TECH_STACK!"=="python" goto :keep_requirements

set /p "keep_requirements=  Keep requirements.txt? (y/N): "
if /i not "!keep_requirements!"=="y" (
    del requirements.txt >nul 2>&1
    echo   Removed requirements.txt
)
goto :create_source

:keep_requirements
echo Python project. Keeping requirements.txt.

:create_source
echo.
echo Creating initial source file...

if /i "!TECH_STACK!"=="Node.js" goto :create_nodejs
if /i "!TECH_STACK!"=="node" goto :create_nodejs
if /i "!TECH_STACK!"=="nodejs" goto :create_nodejs
if /i "!TECH_STACK!"=="Python" goto :create_python
if /i "!TECH_STACK!"=="python" goto :create_python
if /i "!TECH_STACK!"=="Go" goto :create_go
if /i "!TECH_STACK!"=="go" goto :create_go
if /i "!TECH_STACK!"=="golang" goto :create_go
goto :create_generic

:create_nodejs
if /i "!USE_TYPESCRIPT!"=="true" (
    (
        echo // Main entry point for {{PROJECT_NAME}}
        echo console.log^('Welcome to {{PROJECT_NAME}}!'^);
        echo.
        echo // TODO: Add your application logic here
    ) > src\index.ts
    call :replace_placeholders "src\index.ts"
    echo   Created src\index.ts
) else (
    (
        echo // Main entry point for {{PROJECT_NAME}}
        echo console.log^('Welcome to {{PROJECT_NAME}}!'^);
        echo.
        echo // TODO: Add your application logic here
    ) > src\index.js
    call :replace_placeholders "src\index.js"
    echo   Created src\index.js
)
goto :create_gitkeeps

:create_python
(
    echo """Main entry point for {{PROJECT_NAME}}"""
    echo.
    echo def main^(^):
    echo     print^("Welcome to {{PROJECT_NAME}}!"^)
    echo.
    echo if __name__ == "__main__":
    echo     main^(^)
) > src\app.py
call :replace_placeholders "src\app.py"
echo   Created src\app.py
goto :create_gitkeeps

:create_go
(
    echo package main
    echo.
    echo import "fmt"
    echo.
    echo func main^(^) ^{
    echo     fmt.Println^("Welcome to {{PROJECT_NAME}}!"^)
    echo ^}
) > src\main.go
call :replace_placeholders "src\main.go"
echo   Created src\main.go
goto :create_gitkeeps

:create_generic
(
    echo # {{PROJECT_NAME}} Source
    echo.
    echo TODO: Add instructions for your {{TECH_STACK}} project.
) > src\README.md
call :replace_placeholders "src\README.md"
echo   Created src\README.md

:create_gitkeeps
echo. > docs\completed\.gitkeep
echo. > docs\reference\.gitkeep
echo. > public\.gitkeep

REM Optional git init
echo.
set /p "git_init_choice=Initialize a git repository and make an initial commit? (y/N): "
if /i "!git_init_choice!"=="y" (
    if exist ".git" (
        echo   .git already exists - skipping git init
    ) else (
        git init
        git add .
        git commit -m "Initial commit from claude-code-template"
        echo   Git repository initialized with initial commit
    )
)

:done
echo.
echo Setup complete!
echo.
echo   Project:    !PROJECT_NAME!
echo   Type:       !PROJECT_TYPE!
echo   Stack:      !TECH_STACK!
echo   Team:       !TEAM_SIZE!
echo.
echo What to do next:
echo.
echo   1. Open Claude Code in this directory
echo   2. Run /new-session to start your first development session
echo   3. Review docs\ONBOARDING.md - update it with your actual project details
echo   4. Update docs\ACTIVE_ROADMAP.md with your real feature priorities
echo   5. Pick a system prompt from prompts\ that matches your project type
echo   6. Copy .env.example to .env and fill in your secrets
echo.
echo Happy coding!
echo.
pause
