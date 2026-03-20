# Contributing

Thank you for improving this template. This guide explains how it works so you can extend it confidently.

## How the Placeholder System Works

Template files contain `{{PLACEHOLDER}}` tokens that `setup.sh` and `setup.bat` replace at project initialization time. The flow is:

1. User runs `./scripts/setup.sh` and answers prompts
2. Script collects values into shell variables
3. `replace_placeholders()` runs `sed` on each template file, substituting every token
4. Validation scan checks for any unfilled `{{...}}` remaining
5. Post-setup checklist is printed

**To add a new placeholder:**
1. Add the token (e.g., `{{MY_TOKEN}}`) to any template file where it's needed
2. Add a prompt for it in `setup.sh` using `prompt_with_default`
3. Add an escaped variable in `replace_placeholders()` and a `-e "s|{{MY_TOKEN}}|$e_my_token|g"` sed line
4. Mirror the exact same change in `setup.bat` — these two files must stay in sync
5. Add the file to `FILES_TO_UPDATE` in both scripts if it's a new file

## How to Add Support for a New Tech Stack

1. Add a new `case` block in `setup.sh` under the `case "$TECH_STACK" in` section with the stack's commands
2. Mirror the same block in `setup.bat` under the `if /i "!TECH_STACK!"==` chain
3. Add a commented job block in `.github/workflows/ci.yml` and `.github/workflows/lint.yml`
4. Create a new `prompts/your-stack.md` following the structure of the existing prompt files

## How to Add a New Slash Command

1. Create `.claude/commands/your-command.md`
2. Write the command as a natural-language instruction to Claude Code
3. Use `$ARGUMENTS` to reference user-provided input (e.g., `/your-command some-value` → `$ARGUMENTS = "some-value"`)
4. Reference files by path — Claude Code can read them as part of executing the command
5. Add it to the slash commands list in `CLAUDE.md`
6. Add an example to `docs/reference/skills-examples.md`

See `.claude/commands/` for existing examples.

## PR Requirements

- If you change `setup.sh`, you must make the equivalent change in `setup.bat`. PRs that modify one without the other will not be merged.
- Test `setup.sh` end-to-end on Mac or Linux before submitting.
- Test `setup.bat` on Windows if you changed it.
- Do not commit anything in `blueprints/` — this directory is gitignored and private to the repo owner.
- Do not add dependencies to `package.json` or `requirements.txt` without a clear reason documented in the PR description.

## File Structure Reference

```
.claude/
  commands/           — Custom slash commands (one .md file per command)
  settings.json       — Shared hook and MCP configuration
  settings.local.json — Machine-specific overrides (gitignored)

docs/
  DECISIONS.md        — ADR log (why decisions were made)
  KNOWN_ISSUES.md     — Accepted limitations and structural issues
  ONBOARDING.md       — 5-minute onboarding for new devs or Claude sessions
  bugs.md             — Reported bug log (written by /bug command)
  reference/
    skills-examples.md — Guide for writing custom slash commands

prompts/              — System prompts per project type
scripts/
  setup.sh            — Unix/Mac setup (source of truth)
  setup.bat           — Windows setup (must mirror setup.sh)

.github/workflows/
  ci.yml              — Full CI (push to main + PRs)
  lint.yml            — Lint only (every push, every branch)
  deploy.yml          — Deployment placeholder
```
