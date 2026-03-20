# Checkpoint

Snapshot the current project state to a dated archive file.

1. Get today's date in YYYY-MM-DD format
2. Read `docs/CURRENT_STATUS.md`
3. Read `docs/ACTIVE_ROADMAP.md`
4. Create `docs/completed/checkpoint-YYYY-MM-DD.md` with this content:

```markdown
# Checkpoint: YYYY-MM-DD

Snapshot taken at [current time].

---

## Current Status

[paste full contents of docs/CURRENT_STATUS.md here]

---

## Active Roadmap

[paste full contents of docs/ACTIVE_ROADMAP.md here]
```

5. Confirm: "Checkpoint saved to `docs/completed/checkpoint-YYYY-MM-DD.md`."

6. Ask: "Would you like to commit the checkpoint to git? (yes/no)"
   - If yes: run `git add docs/ && git commit -m "chore: checkpoint YYYY-MM-DD"`
   - If no: do nothing further

This command is read-only on project files except for creating the checkpoint file. It is safe to run at any time.
