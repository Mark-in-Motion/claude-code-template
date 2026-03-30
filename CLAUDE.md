# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Type

{{PROJECT_TYPE}}

## Current Focus

<!-- One line: what is being worked on right now. Update this at the start of each session. -->
{{DESCRIPTION}}

## Project Information

**Project Name:** {{PROJECT_NAME}}
**Description:** {{DESCRIPTION}}
**Tech Stack:** {{TECH_STACK}}
**Last Updated:** {{DATE}}

## Constraints

Claude Code must **never** do the following without explicit user confirmation:

- Delete any file or directory (`rm`, `rmdir`, or equivalent)
- Modify `.env`, `.env.local`, or any other environment file — remind the user to update it manually instead
- Push to `main` or `master` directly — always create a branch and open a PR
- Run `rm -rf` on any directory
- Install packages globally without asking first
- Commit secrets, tokens, API keys, or credentials
- Overwrite a file with user-edited content without showing what will change first

## Project Setup and Development Commands

### Initial Setup
Run the setup script to replace placeholders with your project details:
```bash
./scripts/setup.sh             # Unix/Mac
./scripts/setup.sh --dry-run   # Preview substitutions before applying
# or
scripts\setup.bat              # Windows
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
# Python: pip install -r requirements.txt, python app.py, python -m pytest, python -m ruff check .
# Go: go mod tidy, go run main.go, go build, go test ./..., go fmt ./...
# Rust: cargo build, cargo run, cargo test, cargo clippy
```

## Project Architecture

### Documentation Structure
This project follows a structured documentation approach:

- `docs/PROJECT_CONTEXT.md` - Project overview, architecture, and key decisions
- `docs/CURRENT_STATUS.md` - Real-time implementation progress tracking
- `docs/ACTIVE_ROADMAP.md` - Prioritized features and development roadmap
- `docs/blueprints/` - Active feature plans and implementation blueprints
- `docs/architecture/security-posture.md` - Standing security constraints and trust boundaries
- `docs/DECISIONS.md` - Lightweight ADR log: why decisions were made
- `docs/KNOWN_ISSUES.md` - Structural limitations and accepted trade-offs
- `docs/ONBOARDING.md` - Get up to speed in 5 minutes (new dev or fresh Claude session)
- `docs/bugs.md` - Reported bugs log (appended to by `/bug` command)
- `docs/sessions/` - Session-based development tracking with detailed logs
- `docs/completed/` - Archive of completed features and session snapshots
- `docs/reference/` - Technical references, API docs, and architectural decisions
- `docs/reference/skills-examples.md` - Guide for writing custom slash commands

### Code Organization
```
{{PROJECT_NAME}}/
├── src/              # Main application source code
├── public/           # Static assets and public files
├── prompts/          # Swappable system prompts per project type
├── scripts/          # Build, deployment, and utility scripts
└── docs/             # Comprehensive project documentation
```

<!-- Add project-specific directories above as your project grows. -->

## Development Workflow with Claude Code

### Starting a Development Session
1. Read `docs/CURRENT_STATUS.md` to understand current state
2. Run `/new-session` to create a dated session file and set goals
3. Run `/context` at any point to re-orient mid-session

Use `/update-status` at any point to get a quick summary of where things stand.

### During Development
- Update `docs/CURRENT_STATUS.md` as features are implemented
- Document architectural decisions in `docs/DECISIONS.md` as they emerge
- Test thoroughly before moving to next task
- Run project-specific linting and type checking commands
- Reference code locations using `file:line` notation in documentation
- Use `/bug [description]` to log any bugs discovered during development

### Ending a Session
- Update session file with accomplishments and any blockers encountered
- Move completed features to appropriate status in `CURRENT_STATUS.md`
- Run `/checkpoint` to snapshot current state before leaving
- Run `/review` before any commit to run the security gate
- Ensure codebase is in stable, committable state
- Update `ACTIVE_ROADMAP.md` if priorities have shifted

## Claude Code Features

### Custom Slash Commands
Project-specific commands are in `.claude/commands/`:

**Session management**
- `/new-session` — Creates a dated session file and prompts for goals
- `/orient` — Reads onboarding docs and loads the matching project prompt before any work begins
- `/update-status` — Reads git log + CURRENT_STATUS.md and summarizes state
- `/context` — Compact read-only project summary for re-orienting mid-session
- `/checkpoint` — Snapshots current status + roadmap to dated archive, optional commit

**Feature workflow**
- `/start-feature [name]` — Creates feature branch, new session file, updates ACTIVE_ROADMAP.md
- `/close-feature` — Marks feature done, archives session, updates status + roadmap

**Maintenance**
- `/bug [description]` — Logs a bug entry to `docs/bugs.md`
- `/review` — Runs the security gate checklist against staged changes before commit

Add your own by creating `.claude/commands/your-command.md`.

### Prompts Directory
`prompts/` contains swappable system prompts for different project types:
- `prompts/general.md` — Default catch-all
- `prompts/web-app.md` — Frontend/fullstack web apps
- `prompts/api-service.md` — Backend APIs
- `prompts/cli-tool.md` — Command-line tools
- `prompts/data-pipeline.md` — Data and ML projects

Reference the relevant prompt at the start of a Claude session to load project-type-specific conventions.

### Hooks
`.claude/settings.json` configures three hooks:

- **PreToolUse / Bash** — Warns before destructive shell commands (`rm -rf`, truncation, etc.)
- **PreToolUse / Write** — Warns when overwriting an existing file that has content
- **PostToolUse / Edit|Write** — Logs a timestamp to `docs/.last-modified` after file changes
- **PostToolUse / Edit|Write** — Lint-on-save (configure the command for your stack)

Personal/machine-specific overrides go in `.claude/settings.local.json` (gitignored). See `.claude/settings.local.json.example` for options.

### MCP Servers
Add MCP servers in `.claude/settings.json` under `"mcpServers"` to give Claude
access to databases, APIs, or other tools. See Claude Code docs for details.

### Task Tracking
Claude Code has built-in task tracking via TodoWrite/TodoRead — no external tool
needed. Claude will use this automatically for multi-step tasks.

## Code Quality Standards

### General Principles
- Follow established code patterns and conventions in this repository
- Prefer editing existing files over creating new ones unless necessary
- Never commit sensitive information (API keys, tokens, credentials)
- Write self-documenting code with minimal comments unless complex logic requires explanation
- Maintain consistency with existing naming conventions and file organization

### Technology-Specific Guidelines

<!-- Replace this comment block with your project's conventions. Examples:
  React: Use functional components, hooks, TypeScript interfaces
  Python: Follow PEP 8, use type hints, prefer composition over inheritance
  Go: Follow effective Go practices, use interfaces, handle errors explicitly
-->

### Testing and Validation
- Run complete test suite before considering features complete
- Use configured linting tools and fix all warnings
- Verify cross-platform compatibility for scripts and builds
- Test edge cases and error conditions
- Update tests when modifying existing functionality

## Security

### Pre-Commit Security Gate

Before committing, run `/review` or do a manual check — no exceptions, including rapid iteration sessions:

> "Before I commit, do a full security review of everything changed this session. Check for exposed secrets, unconstrained inputs, missing error handling, data privacy issues, and anything risky in a production or shared environment."

### Checklist

**Secrets & API keys**
- Scan for hardcoded strings matching common key prefixes: `sk-`, `ghp_`, `xoxb-`, `AIza`, `AKIA`
- Scan for literal assignments: `password =`, `secret =`, `api_key =`, `token =` in source files
- Check that `.env` files are not staged (`git diff --cached` must not include `.env`)
- Never use `dangerouslyAllowBrowser: true` outside of `import.meta.env.DEV` guards
- Never bundle secrets in the frontend (no `VITE_*` keys that reach the browser in non-local builds)
- Route sensitive API calls through a server-side proxy in production

**Injection & input validation**
- Check for raw SQL string concatenation (e.g., `"SELECT * FROM users WHERE id = " + userId`)
- Check for `eval()` calls on user-supplied or externally sourced data
- Check for unvalidated `req.body` or `request.json()` data passed directly to database queries
- Check for shell command construction from user input (`exec`, `spawn`, `subprocess.run` with string interpolation)

**File system**
- Check for path traversal patterns (`../` in user-supplied file paths)
- Check for file writes to paths derived from user input without sanitization

**Proxy & backend**
- Never forward raw client params to a third-party API without server-side validation
- Enforce allowlists for model names, cap `max_tokens`, limit input size
- Never use CORS wildcard (`*`) on internal proxies — restrict to known origins

**Error handling**
- Every external API call needs a `try/catch` — never silently return `null` on failure
- No unhandled promise rejections — wrap all `await` calls that can throw

**Data privacy**
- Never send full application state to an external API unless required
- Strip/minimise user or project data before including it in AI prompts

**TypeScript**
- Avoid `as any` on external API responses — use proper types or runtime validation

### On Large Feature Branches

After merging branches with new services, integrations, or infrastructure:

> "Review this entire branch for security issues as if preparing it for a production code review. List every risk by severity."

### Rule of Thumb

> If it works locally but you haven't considered what happens in a shared or production environment — you're not done.

## Documentation Maintenance

### Files to Keep Updated
- `docs/PROJECT_CONTEXT.md` - When architecture, tech stack, or core concepts change
- `docs/CURRENT_STATUS.md` - After every significant development session
- `docs/ACTIVE_ROADMAP.md` - When feature priorities change or items are completed
- `docs/blueprints/` - When an active feature plan changes or a new blueprint is created
- `docs/architecture/security-posture.md` - When security constraints or trust boundaries change
- `docs/DECISIONS.md` - When any significant architectural or design decision is made
- `docs/KNOWN_ISSUES.md` - When structural limitations are discovered or accepted
- `CLAUDE.md` (this file) - When development commands or workflow changes

### Session Documentation Best Practices
- Create dated files for each significant development session
- Keep session files to 4 sections: Goal / Done / Blockers / Next Step
- Document decision rationale in `docs/DECISIONS.md` for future reference
- Reference specific code locations when describing changes (`file:line`)
- Archive completed sessions to `docs/completed/` when projects finish

## Project-Specific Configuration

### Build and Deployment

<!-- Add your deployment pipeline commands here. Examples:
  docker build -t {{PROJECT_NAME}} .
  terraform apply
  npm run deploy
  vercel --prod
-->

### Environment Setup

<!-- Add environment-specific setup here. Examples:
  cp .env.example .env   # then fill in values
  docker-compose up -d
  export DATABASE_URL="postgresql://localhost/{{PROJECT_NAME}}"
-->

### Dependencies and Package Management

<!-- Add dependency management commands here. Examples:
  npm audit fix
  pip install --upgrade -r requirements.txt
  go mod tidy && go mod vendor
-->

## Integration and Tools

### Development Tools

<!-- List key development tools and their configurations. Examples:
  ESLint configuration: eslint.config.js
  Prettier configuration: .prettierrc
  Docker configuration: Dockerfile, docker-compose.yml
  CI/CD: .github/workflows/ci.yml
-->

### External Services

<!-- Document external services or APIs used by this project. Examples:
  Database: PostgreSQL on port 5432
  Cache: Redis on port 6379
  Authentication: Auth0 integration
  Payment: Stripe API integration
-->

---

**Template Usage:** Run `./scripts/setup.sh` (or `scripts\setup.bat` on Windows) to replace
all `{{PLACEHOLDER}}` values with your project information. Then remove this footer and
customize the comment blocks above with your project-specific details.
