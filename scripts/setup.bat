@echo off
setlocal EnableDelayedExpansion

goto :main

REM ============================================================
REM Subroutines (defined before :main so goto :main skips them)
REM ============================================================

REM Prompt for input with optional default value
REM Usage: call :prompt_with_default "Prompt text" "default" VAR_NAME
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
    if not "!default_value!"=="" (
        set "!result_var!=!default_value!"
    )
) else (
    set "!result_var!=!user_input!"
)
goto :eof

REM Replace all template placeholders in a file using literal string replacement
REM Usage: call :replace_placeholders "path\to\file"
:replace_placeholders
set "file=%~1"
if exist "!file!" (
    powershell -Command ^
        "$f = '!file!'; " ^
        "$c = [System.IO.File]::ReadAllText($f); " ^
        "$c = $c.Replace('{{PROJECT_NAME}}', '!PROJECT_NAME!'); " ^
        "$c = $c.Replace('{{DESCRIPTION}}', '!DESCRIPTION!'); " ^
        "$c = $c.Replace('{{TECH_STACK}}', '!TECH_STACK!'); " ^
        "$c = $c.Replace('{{DATE}}', '!CURRENT_DATE!'); " ^
        "$c = $c.Replace('{{AUTHOR_NAME}}', '!AUTHOR_NAME!'); " ^
        "$c = $c.Replace('{{PROJECT_KEYWORDS}}', '!PROJECT_KEYWORDS!'); " ^
        "$c = $c.Replace('{{REPOSITORY_URL}}', '!REPOSITORY_URL!'); " ^
        "$c = $c.Replace('{{PROGRAMMING_LANGUAGE}}', '!PROGRAMMING_LANGUAGE!'); " ^
        "$c = $c.Replace('{{FRAMEWORK}}', '!FRAMEWORK!'); " ^
        "$c = $c.Replace('{{DATABASE}}', '!DATABASE!'); " ^
        "$c = $c.Replace('{{DEPLOYMENT_PLATFORM}}', '!DEPLOYMENT_PLATFORM!'); " ^
        "$c = $c.Replace('{{BUILD_COMMAND}}', '!BUILD_COMMAND!'); " ^
        "$c = $c.Replace('{{START_COMMAND}}', '!START_COMMAND!'); " ^
        "$c = $c.Replace('{{TEST_COMMAND}}', '!TEST_COMMAND!'); " ^
        "$c = $c.Replace('{{LINT_COMMAND}}', '!LINT_COMMAND!'); " ^
        "[System.IO.File]::WriteAllText($f, $c)"
    echo ^✅ Updated !file!
)
goto :eof

REM ============================================================
REM Main script entry point
REM ============================================================
:main
echo.
echo AI-Assisted Project Template Setup
echo =====================================
echo.

REM Get current date using PowerShell (wmic is deprecated)
for /f %%I in ('powershell -Command "Get-Date -Format yyyy-MM-dd"') do set CURRENT_DATE=%%I

echo 📝 Please provide your project information:
echo.

REM Gather project information
call :prompt_with_default "Project Name" "my-ai-project" PROJECT_NAME
call :prompt_with_default "Project Description" "An AI-assisted project with comprehensive documentation" DESCRIPTION
call :prompt_with_default "Tech Stack (e.g., Node.js, Python, React)" "Node.js" TECH_STACK
call :prompt_with_default "Programming Language" "JavaScript" PROGRAMMING_LANGUAGE
call :prompt_with_default "Framework" "Express.js" FRAMEWORK
call :prompt_with_default "Database" "PostgreSQL" DATABASE
call :prompt_with_default "Deployment Platform" "Vercel" DEPLOYMENT_PLATFORM
call :prompt_with_default "Author Name" "Your Name" AUTHOR_NAME
call :prompt_with_default "Project Keywords (comma-separated)" "ai-assisted,development,template" PROJECT_KEYWORDS
call :prompt_with_default "Repository URL" "https://github.com/username/repo-name" REPOSITORY_URL

REM Tech stack specific commands
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
set "USE_TYPESCRIPT=false"
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
echo.
echo Updating project files with your information...
echo.

REM Update all template files
call :replace_placeholders "CLAUDE.md"
call :replace_placeholders "package.json"
call :replace_placeholders "docs\PROJECT_CONTEXT.md"
call :replace_placeholders "docs\CURRENT_STATUS.md"
call :replace_placeholders "docs\ACTIVE_ROADMAP.md"
call :replace_placeholders "docs\sessions\latest-session.md"

REM Handle Node.js specific setup
if /i "!TECH_STACK!"=="Node.js" goto :keep_package
if /i "!TECH_STACK!"=="node" goto :keep_package
if /i "!TECH_STACK!"=="nodejs" goto :keep_package

echo Non-Node.js project detected.
set /p "keep_package=   Do you want to keep package.json for future use? (y/N): "
if /i not "!keep_package!"=="y" (
    del package.json >nul 2>&1
    echo Removed package.json
)
goto :check_python

:keep_package
echo Node.js project detected. Keeping package.json.

:check_python
REM Handle Python specific setup
if /i "!TECH_STACK!"=="Python" goto :keep_requirements
if /i "!TECH_STACK!"=="python" goto :keep_requirements

echo Non-Python project detected.
set /p "keep_requirements=   Do you want to keep requirements.txt for future use? (y/N): "
if /i not "!keep_requirements!"=="y" (
    del requirements.txt >nul 2>&1
    echo Removed requirements.txt
)
goto :create_structure

:keep_requirements
echo Python project detected. Keeping requirements.txt.

:create_structure
echo.
echo Creating initial project structure...

REM Create initial project files based on tech stack
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
    echo Created src\index.ts
) else (
    (
        echo // Main entry point for {{PROJECT_NAME}}
        echo console.log^('Welcome to {{PROJECT_NAME}}!'^);
        echo.
        echo // TODO: Add your application logic here
    ) > src\index.js
    call :replace_placeholders "src\index.js"
    echo Created src\index.js
)
goto :create_placeholders

:create_python
(
    echo """
    echo Main entry point for {{PROJECT_NAME}}
    echo """
    echo.
    echo def main^(^):
    echo     print^("Welcome to {{PROJECT_NAME}}!"^)
    echo     # TODO: Add your application logic here
    echo.
    echo if __name__ == "__main__":
    echo     main^(^)
) > src\app.py
call :replace_placeholders "src\app.py"
echo Created src\app.py
goto :create_placeholders

:create_go
(
    echo package main
    echo.
    echo import "fmt"
    echo.
    echo func main^(^) ^{
    echo     fmt.Println^("Welcome to {{PROJECT_NAME}}!"^)
    echo     // TODO: Add your application logic here
    echo ^}
) > src\main.go
call :replace_placeholders "src\main.go"
echo Created src\main.go
goto :create_placeholders

:create_generic
(
    echo # {{PROJECT_NAME}} Source Code
    echo.
    echo This directory contains the main source code for {{PROJECT_NAME}}.
    echo.
    echo ## Getting Started
    echo.
    echo TODO: Add instructions specific to your {{TECH_STACK}} project.
    echo.
    echo ## Structure
    echo.
    echo TODO: Document your project structure here.
) > src\README.md
call :replace_placeholders "src\README.md"
echo Created src\README.md

:create_placeholders
REM Create placeholder files in empty directories
echo. > docs\completed\.gitkeep
echo. > docs\reference\.gitkeep
echo. > public\.gitkeep

echo Created placeholder files for empty directories

echo.
echo Setup Complete!
echo.
echo Your AI-assisted project template has been customized with:
echo   Project Name: !PROJECT_NAME!
echo   Tech Stack: !TECH_STACK!
echo   Author: !AUTHOR_NAME!
echo.
echo Next Steps:
echo   1. Review and customize the generated documentation in docs\
echo   2. Update CLAUDE.md with any additional project-specific information
echo   3. Initialize your git repository: git init ^&^& git add . ^&^& git commit -m "Initial commit"
echo   4. Start your first development session with Claude Code!
echo.
echo Documentation Structure Created:
echo   docs\PROJECT_CONTEXT.md - Project overview and architecture
echo   docs\CURRENT_STATUS.md - Real-time development status
echo   docs\ACTIVE_ROADMAP.md - Feature roadmap and priorities
echo   docs\sessions\ - Development session tracking
echo.
echo Happy coding!

pause
