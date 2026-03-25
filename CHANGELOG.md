# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.0.0] - 2026-03-25

### Added
- Claude Code integration with pre-configured hooks (destructive-op warnings, file overwrite warnings, last-modified log)
- 8 custom slash commands: `/new-session`, `/update-status`, `/context`, `/start-feature`, `/close-feature`, `/bug`, `/checkpoint`, `/review`
- Session-based documentation structure (`docs/sessions/`, `docs/completed/`, `docs/reference/`)
- Cross-platform setup script (`scripts/setup.sh` + `scripts/setup.bat`) with `--dry-run` support
- `{{PLACEHOLDER}}` token substitution system across all template files
- 5 swappable system prompts for different project types (`general`, `web-app`, `api-service`, `cli-tool`, `data-pipeline`)
- GitHub Actions workflows: `ci.yml` (Node, Python, Go, Rust), `lint.yml`, `deploy.yml` (Vercel, Railway, Fly.io)
- Stack support: Node.js, Node.js + TypeScript, Python, Go, Rust, Custom
- ESLint v9 flat config (`eslint.config.js`)
- Comprehensive `.gitignore` covering Node, Python, Go, Rust, IDE files, OS files, secrets

[Unreleased]: https://github.com/Mark-in-Motion/claude-code-template/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Mark-in-Motion/claude-code-template/releases/tag/v1.0.0
