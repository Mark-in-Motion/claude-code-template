#!/bin/bash
set -euo pipefail

# claude-code-template setup script (Unix/Mac)
# Replaces {{PLACEHOLDER}} tokens with your project details.
#
# Usage:
#   ./scripts/setup.sh             # Interactive setup
#   ./scripts/setup.sh --dry-run   # Preview substitutions without changing files

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
fi

echo "AI-Assisted Project Template Setup"
echo "====================================="
if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY RUN] No files will be changed — showing preview only"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────────────────────────────────────

prompt_with_default() {
    local prompt_text="$1"
    local default_value="$2"
    local result_var="$3"

    if [[ -n "$default_value" ]]; then
        echo -n "$prompt_text [$default_value]: "
    else
        echo -n "$prompt_text: "
    fi

    read user_input

    if [[ -z "$user_input" && -n "$default_value" ]]; then
        user_input="$default_value"
    fi

    printf -v "$result_var" '%s' "$user_input"
}

# Escape special sed characters (&, /, \) to prevent injection
escape_for_sed() {
    printf '%s' "$1" | sed 's/[&/\\]/\\&/g'
}

replace_placeholders() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        return
    fi

    local e_project_name e_description e_project_description e_tech_stack
    local e_author_name e_keywords e_repo_url e_lang e_framework e_database
    local e_deploy_platform e_build e_start e_test e_lint e_project_type e_team_size

    e_project_name=$(escape_for_sed "$PROJECT_NAME")
    e_description=$(escape_for_sed "$DESCRIPTION")
    e_project_description=$(escape_for_sed "$PROJECT_DESCRIPTION")
    e_tech_stack=$(escape_for_sed "$TECH_STACK")
    e_author_name=$(escape_for_sed "$AUTHOR_NAME")
    e_keywords=$(escape_for_sed "$PROJECT_KEYWORDS")
    e_repo_url=$(escape_for_sed "$REPOSITORY_URL")
    e_lang=$(escape_for_sed "$PROGRAMMING_LANGUAGE")
    e_framework=$(escape_for_sed "$FRAMEWORK")
    e_database=$(escape_for_sed "$DATABASE")
    e_deploy_platform=$(escape_for_sed "$DEPLOYMENT_PLATFORM")
    e_build=$(escape_for_sed "$BUILD_COMMAND")
    e_start=$(escape_for_sed "$START_COMMAND")
    e_test=$(escape_for_sed "$TEST_COMMAND")
    e_lint=$(escape_for_sed "$LINT_COMMAND")
    e_project_type=$(escape_for_sed "$PROJECT_TYPE")
    e_team_size=$(escape_for_sed "$TEAM_SIZE")

    if [[ "$DRY_RUN" == "true" ]]; then
        local found
        found=$(grep -n '{{' "$file" 2>/dev/null || true)
        if [[ -n "$found" ]]; then
            echo "  [preview] $file:"
            echo "$found" | while IFS= read -r line; do
                echo "    $line"
            done
        else
            echo "  [preview] $file: no placeholders"
        fi
        return
    fi

    sed -i.bak \
        -e "s|{{PROJECT_NAME}}|$e_project_name|g" \
        -e "s|{{DESCRIPTION}}|$e_description|g" \
        -e "s|{{PROJECT_DESCRIPTION}}|$e_project_description|g" \
        -e "s|{{PROJECT_TYPE}}|$e_project_type|g" \
        -e "s|{{TECH_STACK}}|$e_tech_stack|g" \
        -e "s|{{DATE}}|$CURRENT_DATE|g" \
        -e "s|{{AUTHOR_NAME}}|$e_author_name|g" \
        -e "s|{{PROJECT_KEYWORDS}}|$e_keywords|g" \
        -e "s|{{REPOSITORY_URL}}|$e_repo_url|g" \
        -e "s|{{PROGRAMMING_LANGUAGE}}|$e_lang|g" \
        -e "s|{{PRIMARY_LANGUAGE}}|$e_lang|g" \
        -e "s|{{FRAMEWORK}}|$e_framework|g" \
        -e "s|{{DATABASE}}|$e_database|g" \
        -e "s|{{DEPLOYMENT_PLATFORM}}|$e_deploy_platform|g" \
        -e "s|{{BUILD_COMMAND}}|$e_build|g" \
        -e "s|{{START_COMMAND}}|$e_start|g" \
        -e "s|{{TEST_COMMAND}}|$e_test|g" \
        -e "s|{{LINT_COMMAND}}|$e_lint|g" \
        -e "s|{{TEAM_SIZE}}|$e_team_size|g" \
        "$file"

    rm "$file.bak"
    echo "  Updated $file"
}

validate_placeholders() {
    echo ""
    echo "Validating placeholder substitution..."
    local unfilled=()
    for file in "${FILES_TO_UPDATE[@]}"; do
        if [[ -f "$file" ]]; then
            local remaining
            remaining=$(grep -n '{{' "$file" 2>/dev/null || true)
            if [[ -n "$remaining" ]]; then
                unfilled+=("$file")
                echo "  WARNING: Unfilled placeholders in $file:"
                echo "$remaining" | head -5
            fi
        fi
    done

    if [[ ${#unfilled[@]} -gt 0 ]]; then
        echo ""
        echo "WARNING: Some placeholders were not filled. Review the files above."
    else
        echo "  All placeholders filled successfully"
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Collect project information
# ──────────────────────────────────────────────────────────────────────────────

echo ""
echo "Please provide your project information:"
echo ""

prompt_with_default "Project Name" "my-project" PROJECT_NAME
prompt_with_default "Short Description (one-liner tagline)" "A project built with claude-code-template" PROJECT_DESCRIPTION
prompt_with_default "Full Description" "$PROJECT_DESCRIPTION" DESCRIPTION

echo ""
echo "Project type:"
echo "  1) Web App"
echo "  2) API Service"
echo "  3) CLI Tool"
echo "  4) Data Pipeline"
echo "  5) General"
echo -n "Choose [1-5, default 5]: "
read type_choice
case "${type_choice:-5}" in
    1) PROJECT_TYPE="Web App" ;;
    2) PROJECT_TYPE="API Service" ;;
    3) PROJECT_TYPE="CLI Tool" ;;
    4) PROJECT_TYPE="Data Pipeline" ;;
    *) PROJECT_TYPE="General" ;;
esac

echo ""
echo "Team size:"
echo "  1) Solo"
echo "  2) Small team (2-5)"
echo "  3) Team (6+)"
echo -n "Choose [1-3, default 1]: "
read team_choice
case "${team_choice:-1}" in
    2) TEAM_SIZE="small team" ;;
    3) TEAM_SIZE="team" ;;
    *) TEAM_SIZE="solo" ;;
esac

prompt_with_default "Tech Stack (e.g., Node.js, Python, React)" "Node.js" TECH_STACK
prompt_with_default "Programming Language" "JavaScript" PROGRAMMING_LANGUAGE
prompt_with_default "Framework" "Express.js" FRAMEWORK
prompt_with_default "Database" "PostgreSQL" DATABASE
prompt_with_default "Deployment Platform" "Vercel" DEPLOYMENT_PLATFORM
prompt_with_default "Author Name" "$(git config user.name 2>/dev/null || echo 'Your Name')" AUTHOR_NAME
prompt_with_default "Project Keywords (comma-separated)" "ai-assisted,development,template" PROJECT_KEYWORDS
prompt_with_default "Repository URL" "https://github.com/username/repo-name" REPOSITORY_URL

# TypeScript flag
USE_TYPESCRIPT=false

# Tech stack specific commands
case "$TECH_STACK" in
    "Node.js"|"node"|"nodejs")
        echo -n "Use TypeScript? (y/N): "
        read ts_choice
        if [[ "$ts_choice" == "y" || "$ts_choice" == "Y" ]]; then
            USE_TYPESCRIPT=true
            PROGRAMMING_LANGUAGE="TypeScript"
            BUILD_COMMAND="tsc"
            START_COMMAND="node --watch --experimental-strip-types src/index.ts"
        else
            BUILD_COMMAND="npm run build"
            START_COMMAND="node --watch src/index.js"
        fi
        TEST_COMMAND="npm test"
        LINT_COMMAND="npm run lint"
        ;;
    "Python"|"python")
        BUILD_COMMAND="pip install -e ."
        START_COMMAND="python app.py"
        TEST_COMMAND="python -m pytest"
        LINT_COMMAND="python -m ruff check ."
        ;;
    "Go"|"go"|"golang")
        BUILD_COMMAND="go build"
        START_COMMAND="go run main.go"
        TEST_COMMAND="go test ./..."
        LINT_COMMAND="go fmt ./..."
        ;;
    "Rust"|"rust")
        BUILD_COMMAND="cargo build"
        START_COMMAND="cargo run"
        TEST_COMMAND="cargo test"
        LINT_COMMAND="cargo clippy"
        ;;
    *)
        prompt_with_default "Build Command" "make build" BUILD_COMMAND
        prompt_with_default "Start Command" "make start" START_COMMAND
        prompt_with_default "Test Command" "make test" TEST_COMMAND
        prompt_with_default "Lint Command" "make lint" LINT_COMMAND
        ;;
esac

CURRENT_DATE=$(date +"%Y-%m-%d")

# ──────────────────────────────────────────────────────────────────────────────
# Files to process
# ──────────────────────────────────────────────────────────────────────────────

FILES_TO_UPDATE=(
    "CLAUDE.md"
    "README.md"
    "package.json"
    "docs/PROJECT_CONTEXT.md"
    "docs/CURRENT_STATUS.md"
    "docs/ACTIVE_ROADMAP.md"
    "docs/ONBOARDING.md"
    "docs/sessions/latest-session.md"
)

# ──────────────────────────────────────────────────────────────────────────────
# Dry run: preview and exit
# ──────────────────────────────────────────────────────────────────────────────

if [[ "$DRY_RUN" == "true" ]]; then
    echo ""
    echo "Preview of substitutions:"
    echo ""
    for file in "${FILES_TO_UPDATE[@]}"; do
        replace_placeholders "$file"
    done
    echo ""
    echo "Dry run complete. No files were changed."
    echo "Run without --dry-run to apply."
    exit 0
fi

# ──────────────────────────────────────────────────────────────────────────────
# Apply substitutions
# ──────────────────────────────────────────────────────────────────────────────

echo ""
echo "Updating project files..."
echo ""

for file in "${FILES_TO_UPDATE[@]}"; do
    replace_placeholders "$file"
done

validate_placeholders

# ──────────────────────────────────────────────────────────────────────────────
# Node.js / Python cleanup
# ──────────────────────────────────────────────────────────────────────────────

if [[ "$TECH_STACK" == "Node.js" || "$TECH_STACK" == "node" || "$TECH_STACK" == "nodejs" ]]; then
    echo ""
    echo "Node.js project. Keeping package.json."

    if [[ "$USE_TYPESCRIPT" == "true" ]] && command -v node &>/dev/null && [[ -f package.json ]]; then
        node -e "
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
pkg.devDependencies = pkg.devDependencies || {};
pkg.devDependencies['typescript'] = '~5.7.0';
pkg.devDependencies['tsx'] = '~4.19.0';
pkg.devDependencies['@types/node'] = '~22.0.0';
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
"
        echo "  Added TypeScript dependencies to package.json"
    fi
else
    echo ""
    echo "Non-Node.js project."
    echo -n "  Keep package.json? (y/N): "
    read keep_package
    if [[ "$keep_package" != "y" && "$keep_package" != "Y" ]]; then
        rm -f package.json
        echo "  Removed package.json"
    fi
fi

if [[ "$TECH_STACK" == "Python" || "$TECH_STACK" == "python" ]]; then
    echo "Python project. Keeping requirements.txt."
else
    echo -n "  Keep requirements.txt? (y/N): "
    read keep_requirements
    if [[ "$keep_requirements" != "y" && "$keep_requirements" != "Y" ]]; then
        rm -f requirements.txt
        echo "  Removed requirements.txt"
    fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# Create initial source file
# ──────────────────────────────────────────────────────────────────────────────

echo ""
echo "Creating initial source file..."

case "$TECH_STACK" in
    "Node.js"|"node"|"nodejs")
        if [[ "$USE_TYPESCRIPT" == "true" ]]; then
            cat > src/index.ts << 'SRCEOF'
// Main entry point for {{PROJECT_NAME}}
console.log('Welcome to {{PROJECT_NAME}}!');

// TODO: Add your application logic here
SRCEOF
            replace_placeholders "src/index.ts"
            echo "  Created src/index.ts"
        else
            cat > src/index.js << 'SRCEOF'
// Main entry point for {{PROJECT_NAME}}
console.log('Welcome to {{PROJECT_NAME}}!');

// TODO: Add your application logic here
SRCEOF
            replace_placeholders "src/index.js"
            echo "  Created src/index.js"
        fi
        ;;
    "Python"|"python")
        cat > src/app.py << 'SRCEOF'
"""Main entry point for {{PROJECT_NAME}}"""


def main():
    print("Welcome to {{PROJECT_NAME}}!")
    # TODO: Add your application logic here


if __name__ == "__main__":
    main()
SRCEOF
        replace_placeholders "src/app.py"
        echo "  Created src/app.py"
        ;;
    "Go"|"go"|"golang")
        cat > src/main.go << 'SRCEOF'
package main

import "fmt"

func main() {
    fmt.Println("Welcome to {{PROJECT_NAME}}!")
    // TODO: Add your application logic here
}
SRCEOF
        replace_placeholders "src/main.go"
        echo "  Created src/main.go"
        ;;
    *)
        cat > src/README.md << 'SRCEOF'
# {{PROJECT_NAME}} Source

TODO: Add instructions for your {{TECH_STACK}} project.
SRCEOF
        replace_placeholders "src/README.md"
        echo "  Created src/README.md"
        ;;
esac

# Create .gitkeep files for empty directories
touch docs/completed/.gitkeep
touch docs/reference/.gitkeep
touch public/.gitkeep

# ──────────────────────────────────────────────────────────────────────────────
# Optional: git init + initial commit
# ──────────────────────────────────────────────────────────────────────────────

echo ""
echo -n "Initialize a git repository and make an initial commit? (y/N): "
read git_init_choice
if [[ "$git_init_choice" == "y" || "$git_init_choice" == "Y" ]]; then
    if [[ -d ".git" ]]; then
        echo "  .git already exists — skipping git init"
    else
        git init
        git add .
        git commit -m "Initial commit from claude-code-template"
        echo "  Git repository initialized with initial commit"
    fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# Point git remote to the new repo
# ──────────────────────────────────────────────────────────────────────────────

if [[ -d ".git" ]]; then
    current_remote=$(git remote get-url origin 2>/dev/null || echo "")
    echo ""
    if [[ -n "$current_remote" ]]; then
        echo "Current git remote: $current_remote"
    fi
    echo -n "Enter your new GitHub repo URL to update the remote (leave blank to skip): "
    read new_remote_url
    if [[ -n "$new_remote_url" ]]; then
        if git remote get-url origin &>/dev/null; then
            git remote set-url origin "$new_remote_url"
        else
            git remote add origin "$new_remote_url"
        fi
        echo "  Remote 'origin' updated to $new_remote_url"
        echo ""
        echo "  Note: GitHub no longer accepts passwords for git push over HTTPS."
        echo "  Use a Personal Access Token (PAT) instead:"
        echo "    GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)"
        echo "    Required scopes: repo, workflow"
    fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# Done
# ──────────────────────────────────────────────────────────────────────────────

echo ""
echo "Setup complete!"
echo ""
echo "  Project:    $PROJECT_NAME"
echo "  Type:       $PROJECT_TYPE"
echo "  Stack:      $TECH_STACK"
echo "  Team:       $TEAM_SIZE"
echo ""
echo "What to do next:"
echo ""
echo "  1. Open Claude Code in this directory"
echo "  2. Run /new-session to start your first development session"
echo "  3. Review docs/ONBOARDING.md — update it with your actual project details"
echo "  4. Update docs/ACTIVE_ROADMAP.md with your real feature priorities"
echo "  5. Pick a system prompt from prompts/ that matches your project type"
echo "  6. Copy .env.example to .env and fill in your secrets"
echo ""
echo "Docs created:"
echo "  docs/PROJECT_CONTEXT.md   — project overview and architecture"
echo "  docs/CURRENT_STATUS.md    — real-time development status"
echo "  docs/ACTIVE_ROADMAP.md    — feature roadmap"
echo "  docs/ONBOARDING.md        — 5-minute onboarding guide"
echo "  docs/DECISIONS.md         — ADR log"
echo "  docs/KNOWN_ISSUES.md      — known issues tracker"
echo "  docs/sessions/            — session logs"
echo ""
echo "Happy coding!"
