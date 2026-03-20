# Custom Slash Commands — Guide and Examples

Claude Code slash commands are markdown files in `.claude/commands/`. When you type `/command-name` in Claude Code, it loads the file and executes it as an instruction.

---

## How slash commands work

- **One file = one command.** File name becomes the slash command name: `context.md` → `/context`
- **Arguments:** Use `$ARGUMENTS` to reference anything the user types after the command name. `/bug login fails on safari` → `$ARGUMENTS = "login fails on safari"`
- **Reading files:** Claude Code can read files as part of executing a command — just reference paths in the instruction
- **Writing files:** Claude Code can write or append to files as an action within a command
- **Chaining:** A command can instruct Claude to run multiple operations in sequence

---

## Example: `/new-session`

**File:** `.claude/commands/new-session.md`

**What it does:** Creates a dated session file, reads current status, and asks for the session goal.

**Why it works:** It combines a file creation action with a status read and a single prompt. Keeps session startup fast and consistent.

---

## Example: `/update-status`

**File:** `.claude/commands/update-status.md`

**What it does:** Reads `docs/CURRENT_STATUS.md` and recent git log, then summarizes the current state of the project.

**Why it works:** It's read-only — no file changes unless the user confirms an update. Safe to run anytime.

---

## Example: `/context`

**File:** `.claude/commands/context.md`

**What it does:** Dumps a compact project summary — type, current focus, last session, current branch, last 5 commits. All read-only.

**Why it works:** Useful mid-session when Claude Code has lost context. Faster than re-reading all docs manually.

---

## Example: `/bug [description]`

**File:** `.claude/commands/bug.md`

**What it does:** Appends a timestamped bug entry to `docs/bugs.md`.

```markdown
# Usage example
/bug login button doesn't respond on mobile Safari
```

**Why it works:** Captures bugs in the moment without context-switching to an issue tracker. The description becomes the bug entry.

---

## Example: `/checkpoint`

**File:** `.claude/commands/checkpoint.md`

**What it does:** Reads `docs/CURRENT_STATUS.md` and `docs/ACTIVE_ROADMAP.md`, writes a snapshot to `docs/completed/checkpoint-YYYY-MM-DD.md`, and optionally commits the docs.

**Why it works:** Preserves a snapshot of project state before a long break or a risky change. Cheap insurance.

---

## How to write your own command

**1. Create the file**
```
.claude/commands/my-command.md
```

**2. Write it as an instruction to Claude Code**

```markdown
# My Command

Read `docs/CURRENT_STATUS.md` and `docs/ACTIVE_ROADMAP.md`.

Then do the following:
1. [step one]
2. [step two]
3. [step three]

If $ARGUMENTS is provided, use it as [explanation of what argument means].
```

**3. Use it**
```
/my-command optional-argument-here
```

**Tips:**
- Keep commands focused — one clear job per command
- Start with reads before writes so Claude has context before acting
- Use `$ARGUMENTS` for user input; if empty, handle gracefully (ask or use a default)
- Add it to the slash commands list in `CLAUDE.md` so it's documented
