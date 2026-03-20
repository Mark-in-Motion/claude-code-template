# Context

Print a compact project summary for quick re-orientation mid-session.

This command is read-only. Do not modify any files or ask follow-up questions.

1. Read the first section of `docs/ONBOARDING.md` (project type and one-liner description)
2. Read `docs/CURRENT_STATUS.md` — extract only the "Current Focus" or equivalent active section (first ~20 lines)
3. Find the most recent file in `docs/sessions/` and read it
4. Run `git branch --show-current`
5. Run `git log --oneline -5`

Output a summary in this format (keep it under 25 lines total):

```
── Project ─────────────────────────────────
Type:    [project type]
What:    [one-liner description]

── Current Focus ────────────────────────────
[2-3 lines from CURRENT_STATUS.md current focus section]

── Last Session ─────────────────────────────
[session date and goal line from most recent session file]

── Git ──────────────────────────────────────
Branch:  [current branch]
Commits: [last 5 log lines]
─────────────────────────────────────────────
```

Do not add explanations, commentary, or suggestions. Just print the summary.
