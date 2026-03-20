# Bug

Log a bug to `docs/bugs.md`.

If $ARGUMENTS is empty, ask: "Please describe the bug." and use their response as the description.

Otherwise:

1. Get today's date in YYYY-MM-DD format
2. Append the following entry to `docs/bugs.md`:

```markdown
## [YYYY-MM-DD] $ARGUMENTS

**Reported:** YYYY-MM-DD
**Status:** Open
**Severity:** TBD
**Details:** $ARGUMENTS
```

3. Confirm: "Bug logged to `docs/bugs.md`."

Do not try to fix the bug unless the user explicitly asks. The purpose of this command is capture, not resolution.
