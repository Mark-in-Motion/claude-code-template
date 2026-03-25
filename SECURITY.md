# Security Policy

## Supported Versions

| Version | Supported |
|---|---|
| 1.x.x | ✅ |
| < 1.0 | ❌ |

## Reporting a Vulnerability

**Please do not open a public GitHub issue for security vulnerabilities.**

Use [GitHub's private vulnerability reporting](https://github.com/Mark-in-Motion/claude-code-template/security/advisories/new) to report issues confidentially.

You can expect:
- **Acknowledgement** within 48 hours
- **Status update** within 7 days
- **Resolution or mitigation** communicated before any public disclosure

## Scope

This is a project template — not a deployed service. Security concerns most relevant to this repo:

- Secrets or credentials accidentally committed to the template
- Malicious code introduced via a dependency in `package.json`
- Hooks in `.claude/settings.json` that execute dangerous commands
- CI workflow files that exfiltrate secrets or introduce supply-chain risk

## Out of Scope

- Vulnerabilities in projects *built with* this template (report those to the respective project)
- GitHub Actions vulnerabilities in third-party actions we use (report to the action author)
- Issues requiring physical access to a machine
