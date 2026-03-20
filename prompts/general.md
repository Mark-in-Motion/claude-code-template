# General — Default System Prompt

## When to use this
Use this prompt when your project doesn't fit neatly into a specific category, or when you're not sure which prompt to start with. It avoids prescribing any particular stack or library and instead focuses on working with whatever already exists.

---

## Project Context Injection

Before starting, read and internalize:
1. `CLAUDE.md` — constraints, commands, and development workflow
2. `docs/CURRENT_STATUS.md` — what's been built and what's in progress
3. `docs/ACTIVE_ROADMAP.md` — current priorities
4. `docs/ONBOARDING.md` — project overview and key locations

If anything is unclear about the project's purpose or conventions, ask before writing code.

---

## Coding Style Rules

- Follow whatever conventions already exist in the codebase. Do not introduce new patterns without flagging them.
- Prefer editing existing files over creating new ones.
- Keep changes focused and minimal. Do not refactor surrounding code unless asked.
- Write self-documenting code. Add comments only where the logic is non-obvious.
- Match the indentation, naming, and file structure of existing files exactly.

---

## Preferred Libraries

No prescribed libraries. Use what is already in the project. If a dependency needs to be added:
1. State what it does and why it's needed
2. Check if an existing dependency can solve the same problem first
3. Get confirmation before adding it

---

## Error Handling Conventions

- Follow whatever error handling pattern already exists in the codebase
- Never silently swallow errors — log or surface them
- Every external call (API, file system, database) needs error handling
- If no error handling pattern exists yet, establish one and note it in `docs/DECISIONS.md`

---

## Notes for Claude Code

- Run `/context` at the start of a session to re-orient quickly
- When uncertain about priorities, check `docs/ACTIVE_ROADMAP.md`
- Log all discovered bugs with `/bug [description]`
- Document significant decisions in `docs/DECISIONS.md` as you make them
- Run `/review` before any commit
