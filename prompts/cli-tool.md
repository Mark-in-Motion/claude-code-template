# CLI Tool — System Prompt

## When to use this
Use this prompt for command-line tools and scripts — anything invoked from a terminal and used by developers, operators, or end users via flags and subcommands.

---

## Project Context Injection

Before starting, read and internalize:
1. `CLAUDE.md` — constraints, commands, and development workflow
2. `docs/CURRENT_STATUS.md` — what's been built and what's in progress
3. `docs/ACTIVE_ROADMAP.md` — current priorities
4. `docs/ONBOARDING.md` — project overview and key locations

---

## Coding Style Rules

- Follow the Unix philosophy: do one thing well, compose with other tools
- Print errors to stderr, not stdout — this preserves pipeline composability
- Always exit with a non-zero exit code on failure — scripts depend on this
- Support `--help` on every command and subcommand
- Support `--verbose` or `-v` for debug output
- Flags should have both short (`-o`) and long (`--output`) forms where it makes sense
- Never prompt for input in non-interactive mode — detect TTY and fail with a useful error instead

---

## Preferred Libraries

**Node.js**
- `commander` or `yargs` for argument parsing
- `chalk` or `picocolors` for terminal color (keep it optional / check NO_COLOR)
- `ora` for progress spinners

**Python**
- `click` or `typer` for argument parsing (typer preferred for type-annotated code)
- `rich` for formatted terminal output

**Go**
- `cobra` for subcommand CLIs
- `lipgloss` (via Charm) for styled output

**Rust**
- `clap` for argument parsing
- `indicatif` for progress bars

---

## Error Handling Conventions

- Exit code 0 = success, non-zero = failure (follow POSIX conventions)
- Print a clear, actionable error message to stderr before exiting non-zero
- For `--verbose` mode, print the full error and stack/context to stderr
- Never panic or throw unhandled exceptions in production code paths
- Validate all inputs (files, flags, environment variables) before executing the main operation
- For destructive operations (delete, overwrite, deploy), require explicit confirmation or a `--force` flag

---

## Notes for Claude Code

- Run `/context` at the start of a session to re-orient quickly
- Check `docs/ACTIVE_ROADMAP.md` for the next subcommand or feature to implement
- Log bugs with `/bug [description]`
- Run `/review` before committing — check for shell injection and unvalidated inputs
- Document any non-obvious flag design choices in `docs/DECISIONS.md`
