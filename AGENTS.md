# AGENTS.md

This file provides guidance to Codex when working in this repository.

## Project Type

{{PROJECT_TYPE}}

## Current Focus

**Project Name:** {{PROJECT_NAME}}
**Description:** {{DESCRIPTION}}
**Tech Stack:** {{TECH_STACK}}
**Last Updated:** {{DATE}}

## Constraints

Codex must **never** do the following without explicit user confirmation:

- Delete any file or directory
- Modify `.env`, `.env.local`, or any other environment file
- Push to `main` or `master` directly
- Run `rm -rf` on any directory
- Install packages globally without asking first
- Commit secrets, tokens, API keys, or credentials
- Overwrite a file with user-edited content without showing what will change first

## Source Organization

### `src/`
Use these directories for new application code:

- `components/` for reusable UI and view building blocks
- `services/` for API calls, data access, and business logic
- `utils/` for shared helpers and pure utility code
- `hooks/` for reusable stateful hooks

Prefer adding code to these locations before introducing new top-level source folders.

## Documentation Protocol

### Required Updates

- Update `CHANGELOG.md` after every session
- Update `docs/reference/ui-terminology.md` whenever UI labels, names, or copy conventions change
- Update `docs/architecture/security-posture.md` whenever security constraints, data-flow rules, or trust boundaries change

### Blueprint Lifecycle

- Active feature blueprints live in `docs/blueprints/`
- Move a blueprint to `docs/archive/blueprints/` only when it is fully shipped and all acceptance criteria are complete
- Do not keep shipping blueprints in the archive

### Docs Boundaries

- Never create session-notes files inside `docs/`
- Never create loose planning documents inside `docs/`
- Keep session tracking in the existing session folders and feature plans in the blueprint flow above

## Project Setup and Development Commands

### Initial Setup
Run the setup script to replace placeholders with your project details:
```bash
./scripts/setup.sh             # Unix/Mac
./scripts/setup.sh --dry-run   # Preview substitutions before applying
# or
scripts\setup.bat              # Windows
```

## Development Workflow

- Read the current docs before making changes
- Keep edits additive or refinements only unless the user explicitly requests otherwise
- Favor existing file structure over introducing new top-level patterns

## Security

- Treat `docs/architecture/security-posture.md` as the standing reference for security constraints
- Re-check that document whenever a change touches external APIs, auth, CORS, AI payloads, or dev-only routes
