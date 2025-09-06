#!/bin/bash

# AI-Assisted Project Template Setup Script (Unix/Mac)
# This script replaces placeholders with actual project information

echo "🚀 AI-Assisted Project Template Setup"
echo "====================================="

# Function to prompt for input with default value
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
    
    eval "$result_var=\"$user_input\""
}

# Function to replace placeholders in a file
replace_placeholders() {
    local file="$1"
    if [[ -f "$file" ]]; then
        # Use different delimiter to avoid conflicts with URLs/paths
        sed -i.bak \
            -e "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" \
            -e "s|{{DESCRIPTION}}|$DESCRIPTION|g" \
            -e "s|{{TECH_STACK}}|$TECH_STACK|g" \
            -e "s|{{DATE}}|$CURRENT_DATE|g" \
            -e "s|{{AUTHOR_NAME}}|$AUTHOR_NAME|g" \
            -e "s|{{PROJECT_KEYWORDS}}|$PROJECT_KEYWORDS|g" \
            -e "s|{{REPOSITORY_URL}}|$REPOSITORY_URL|g" \
            -e "s|{{PROGRAMMING_LANGUAGE}}|$PROGRAMMING_LANGUAGE|g" \
            -e "s|{{FRAMEWORK}}|$FRAMEWORK|g" \
            -e "s|{{DATABASE}}|$DATABASE|g" \
            -e "s|{{DEPLOYMENT_PLATFORM}}|$DEPLOYMENT_PLATFORM|g" \
            -e "s|{{BUILD_COMMAND}}|$BUILD_COMMAND|g" \
            -e "s|{{START_COMMAND}}|$START_COMMAND|g" \
            -e "s|{{TEST_COMMAND}}|$TEST_COMMAND|g" \
            -e "s|{{LINT_COMMAND}}|$LINT_COMMAND|g" \
            "$file"
        
        # Remove backup file
        rm "$file.bak"
        echo "✅ Updated $file"
    fi
}

echo ""
echo "📝 Please provide your project information:"
echo ""

# Gather project information
prompt_with_default "Project Name" "my-ai-project" PROJECT_NAME
prompt_with_default "Project Description" "An AI-assisted project with comprehensive documentation" DESCRIPTION
prompt_with_default "Tech Stack (e.g., Node.js, Python, React)" "Node.js" TECH_STACK
prompt_with_default "Programming Language" "JavaScript" PROGRAMMING_LANGUAGE
prompt_with_default "Framework" "Express.js" FRAMEWORK
prompt_with_default "Database" "PostgreSQL" DATABASE
prompt_with_default "Deployment Platform" "Heroku" DEPLOYMENT_PLATFORM
prompt_with_default "Author Name" "$(git config user.name 2>/dev/null || echo 'Your Name')" AUTHOR_NAME
prompt_with_default "Project Keywords (comma-separated)" "ai-assisted,development,template" PROJECT_KEYWORDS
prompt_with_default "Repository URL" "https://github.com/username/repo-name" REPOSITORY_URL

# Tech stack specific commands
case "$TECH_STACK" in
    "Node.js"|"node"|"nodejs")
        BUILD_COMMAND="npm run build"
        START_COMMAND="npm start"
        TEST_COMMAND="npm test"
        LINT_COMMAND="npm run lint"
        ;;
    "Python"|"python")
        BUILD_COMMAND="python setup.py build"
        START_COMMAND="python app.py"
        TEST_COMMAND="python -m pytest"
        LINT_COMMAND="python -m flake8"
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

# Get current date
CURRENT_DATE=$(date +"%Y-%m-%d")

echo ""
echo "🔄 Updating project files with your information..."
echo ""

# List of files to update
FILES_TO_UPDATE=(
    "CLAUDE.md"
    "package.json"
    "docs/PROJECT_CONTEXT.md"
    "docs/CURRENT_STATUS.md"
    "docs/ACTIVE_ROADMAP.md"
    "docs/sessions/latest-session.md"
)

# Replace placeholders in each file
for file in "${FILES_TO_UPDATE[@]}"; do
    replace_placeholders "$file"
done

# Handle Node.js specific setup
if [[ "$TECH_STACK" == "Node.js" || "$TECH_STACK" == "node" || "$TECH_STACK" == "nodejs" ]]; then
    echo "📦 Node.js project detected. Keeping package.json."
else
    echo "📦 Non-Node.js project detected."
    echo "   Do you want to keep package.json for future use? (y/N): "
    read keep_package
    if [[ "$keep_package" != "y" && "$keep_package" != "Y" ]]; then
        rm -f package.json
        echo "✅ Removed package.json"
    fi
fi

# Handle Python specific setup
if [[ "$TECH_STACK" == "Python" || "$TECH_STACK" == "python" ]]; then
    echo "🐍 Python project detected. Keeping requirements.txt."
else
    echo "🐍 Non-Python project detected."
    echo "   Do you want to keep requirements.txt for future use? (y/N): "
    read keep_requirements
    if [[ "$keep_requirements" != "y" && "$keep_requirements" != "Y" ]]; then
        rm -f requirements.txt
        echo "✅ Removed requirements.txt"
    fi
fi

# Create initial project structure files
echo ""
echo "📁 Creating initial project structure..."

# Create a basic index file based on tech stack
case "$TECH_STACK" in
    "Node.js"|"node"|"nodejs")
        cat > src/index.js << 'EOF'
// Main entry point for {{PROJECT_NAME}}
console.log('Welcome to {{PROJECT_NAME}}!');

// TODO: Add your application logic here
EOF
        replace_placeholders "src/index.js"
        echo "✅ Created src/index.js"
        ;;
    "Python"|"python")
        cat > src/app.py << 'EOF'
"""
Main entry point for {{PROJECT_NAME}}
"""

def main():
    print("Welcome to {{PROJECT_NAME}}!")
    # TODO: Add your application logic here

if __name__ == "__main__":
    main()
EOF
        replace_placeholders "src/app.py"
        echo "✅ Created src/app.py"
        ;;
    "Go"|"go"|"golang")
        cat > src/main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Welcome to {{PROJECT_NAME}}!")
    // TODO: Add your application logic here
}
EOF
        replace_placeholders "src/main.go"
        echo "✅ Created src/main.go"
        ;;
    *)
        cat > src/README.md << 'EOF'
# {{PROJECT_NAME}} Source Code

This directory contains the main source code for {{PROJECT_NAME}}.

## Getting Started

TODO: Add instructions specific to your {{TECH_STACK}} project.

## Structure

TODO: Document your project structure here.
EOF
        replace_placeholders "src/README.md"
        echo "✅ Created src/README.md"
        ;;
esac

# Create placeholder files in empty directories
touch docs/completed/.gitkeep
touch docs/reference/.gitkeep
touch public/.gitkeep

echo "✅ Created placeholder files for empty directories"

# Make the script executable (in case it wasn't)
chmod +x scripts/setup.sh

echo ""
echo "🎉 Setup Complete!"
echo ""
echo "Your AI-assisted project template has been customized with:"
echo "  • Project Name: $PROJECT_NAME"
echo "  • Tech Stack: $TECH_STACK"
echo "  • Author: $AUTHOR_NAME"
echo ""
echo "📚 Next Steps:"
echo "  1. Review and customize the generated documentation in docs/"
echo "  2. Update CLAUDE.md with any additional project-specific information"
echo "  3. Initialize your git repository: git init && git add . && git commit -m 'Initial commit'"
echo "  4. Start your first development session with Claude Code!"
echo ""
echo "🤖 Documentation Structure Created:"
echo "  • docs/PROJECT_CONTEXT.md - Project overview and architecture"
echo "  • docs/CURRENT_STATUS.md - Real-time development status"
echo "  • docs/ACTIVE_ROADMAP.md - Feature roadmap and priorities"
echo "  • docs/sessions/ - Development session tracking"
echo ""
echo "Happy coding! 🚀"