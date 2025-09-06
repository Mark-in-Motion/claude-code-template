# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Information

**Project Name:** {{PROJECT_NAME}}
**Description:** {{DESCRIPTION}}
**Tech Stack:** {{TECH_STACK}}
**Last Updated:** {{DATE}}

## Project Setup and Development Commands

### Initial Setup
Run the setup script to replace placeholders with your project details:
```bash
./scripts/setup.sh    # Unix/Mac
# or
scripts\setup.bat     # Windows
```

### Development Commands
```bash
# {{TECH_STACK}} Development Commands
{{BUILD_COMMAND}}     # Build the project
{{START_COMMAND}}     # Start development server
{{TEST_COMMAND}}      # Run tests
{{LINT_COMMAND}}      # Run linting/formatting

# Example commands for common stacks:
# Node.js: npm install, npm start, npm run build, npm test, npm run lint
# Python: pip install -r requirements.txt, python app.py, python -m pytest, python -m flake8
# Go: go mod tidy, go run main.go, go build, go test ./..., go fmt ./...
# Rust: cargo build, cargo run, cargo test, cargo clippy
```

## Project Architecture

### Documentation Structure
This project follows a structured documentation approach:

- `docs/PROJECT_CONTEXT.md` - Project overview, architecture, and key decisions
- `docs/CURRENT_STATUS.md` - Real-time implementation progress tracking
- `docs/ACTIVE_ROADMAP.md` - Prioritized features and development roadmap
- `docs/sessions/` - Session-based development tracking with detailed logs
- `docs/completed/` - Archive of completed features and implementation notes
- `docs/reference/` - Technical references, API docs, and architectural decisions

### Code Organization
```
{{PROJECT_NAME}}/
├── src/              # Main application source code
├── public/           # Static assets and public files  
├── scripts/          # Build, deployment, and utility scripts
├── {{ADDITIONAL_FOLDERS}}  # Project-specific directories
└── docs/             # Comprehensive project documentation
```

## Development Workflow with Claude Code

### Starting a Development Session
1. Review `docs/CURRENT_STATUS.md` to understand current project state
2. Check `docs/ACTIVE_ROADMAP.md` for next priority features/fixes
3. Create new session file in `docs/sessions/` with current date
4. Define clear goals for the development session
5. Focus on one major feature or component per session

### During Development
- Update `docs/CURRENT_STATUS.md` as features are implemented
- Document architectural decisions and design patterns as they emerge
- Test thoroughly before moving to next task
- Run project-specific linting and type checking commands
- Reference code locations using `file:line` notation in documentation

### Ending a Session
- Update session file with accomplishments and any blockers encountered
- Move completed features to appropriate status in `CURRENT_STATUS.md`
- Ensure codebase is in stable, committable state
- Update `ACTIVE_ROADMAP.md` if priorities have shifted

## Code Quality Standards

### General Principles
- Follow established code patterns and conventions in this repository
- Prefer editing existing files over creating new ones unless necessary
- Never commit sensitive information (API keys, tokens, credentials)
- Write self-documenting code with minimal comments unless complex logic requires explanation
- Maintain consistency with existing naming conventions and file organization

### Technology-Specific Guidelines
```
{{TECH_SPECIFIC_GUIDELINES}}
# Examples:
# React: Use functional components, hooks, TypeScript interfaces
# Python: Follow PEP 8, use type hints, prefer composition over inheritance  
# Go: Follow effective Go practices, use interfaces, handle errors explicitly
# Add your project's specific conventions here
```

### Testing and Validation
- Run complete test suite before considering features complete
- Use configured linting tools and fix all warnings
- Verify cross-platform compatibility for scripts and builds
- Test edge cases and error conditions
- Update tests when modifying existing functionality

## Documentation Maintenance

### Files to Keep Updated
- `docs/PROJECT_CONTEXT.md` - When architecture, tech stack, or core concepts change
- `docs/CURRENT_STATUS.md` - After every significant development session
- `docs/ACTIVE_ROADMAP.md` - When feature priorities change or items are completed
- `CLAUDE.md` (this file) - When development commands or workflow changes

### Session Documentation Best Practices
- Create dated files for each significant development session
- Include session goals, key accomplishments, blockers, and next steps
- Document decision rationale for future reference
- Reference specific code locations when describing changes
- Archive completed sessions to `docs/completed/` when projects finish

## Project-Specific Configuration

### Build and Deployment
```bash
{{DEPLOYMENT_COMMANDS}}
# Add your specific deployment pipeline commands
# Examples:
# docker build -t {{PROJECT_NAME}} .
# terraform apply
# npm run deploy
```

### Environment Setup
```bash
{{ENVIRONMENT_SETUP}}
# Add environment-specific configuration
# Examples:
# export DATABASE_URL="postgresql://localhost/{{PROJECT_NAME}}"
# source .env.development
# docker-compose up -d
```

### Dependencies and Package Management
```bash
{{DEPENDENCY_MANAGEMENT}}
# Add dependency management commands
# Examples:
# npm audit fix
# pip install --upgrade -r requirements.txt
# go mod tidy && go mod vendor
```

## Integration and Tools

### Development Tools
```
{{DEVELOPMENT_TOOLS}}
# List key development tools and their configurations
# Examples:
# ESLint configuration: .eslintrc.js
# Prettier configuration: .prettierrc
# Docker configuration: Dockerfile, docker-compose.yml
# CI/CD: .github/workflows/
```

### External Services
```
{{EXTERNAL_SERVICES}}
# Document any external services or APIs used
# Examples:
# Database: PostgreSQL on port 5432
# Cache: Redis on port 6379  
# Authentication: Auth0 integration
# Payment: Stripe API integration
```

---

**Template Usage:** This file serves as both documentation and configuration for Claude Code. Replace all `{{PLACEHOLDER}}` values with your project-specific information after running the setup script. Remove any sections that don't apply to your project type.