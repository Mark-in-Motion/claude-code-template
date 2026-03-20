# Start Feature

Begin work on a named feature.

If $ARGUMENTS is empty, respond: "Please provide a feature name: `/start-feature my-feature-name`" and stop.

Otherwise, do the following in order:

1. Run `git branch --show-current` to confirm the current branch
2. Create a new git branch: `git checkout -b feature/$ARGUMENTS`
   - If the branch already exists, note it and check it out instead
3. Get today's date in YYYY-MM-DD format
4. Create a new session file at `docs/sessions/YYYY-MM-DD-$ARGUMENTS.md` with this content:

```markdown
# Session: YYYY-MM-DD — $ARGUMENTS

## Goal
[Starting work on feature: $ARGUMENTS]

## Done
-

## Blockers
- None

## Next Step
[First task for this feature]
```

5. Read `docs/ACTIVE_ROADMAP.md` and add an entry under an "In Progress" section for this feature with today's date:
   `- [ ] $ARGUMENTS — started YYYY-MM-DD`
   If the file doesn't have an "In Progress" section, add one before the first phase section.

6. Confirm to the user:
   - Branch created: `feature/$ARGUMENTS`
   - Session file: `docs/sessions/YYYY-MM-DD-$ARGUMENTS.md`
   - Roadmap updated

Then ask: "What is the goal for this session?"
