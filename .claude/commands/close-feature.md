# Close Feature

Mark the current feature as complete and archive the session.

1. Run `git branch --show-current` to get the current branch name
   - If the branch is `main` or `master`, warn: "You're on the main branch. Are you sure you want to close a feature from here?" and ask for confirmation before continuing.
   - Extract the feature name: if branch is `feature/my-feature`, the feature name is `my-feature`

2. Find the most recent session file in `docs/sessions/` that matches today's date or the feature name

3. Append to the session file:
   ```
   ---
   Session closed: YYYY-MM-DD
   ```

4. Move (copy + note) the session file to `docs/completed/` — instruct the user to run:
   ```bash
   mv docs/sessions/YYYY-MM-DD-FEATURE.md docs/completed/
   ```
   (Claude Code cannot move files directly — ask the user to confirm this step)

5. Read `docs/CURRENT_STATUS.md` and update the status for this feature to complete (✅)

6. Read `docs/ACTIVE_ROADMAP.md` and mark the feature item as done:
   - Change `- [ ] feature-name` to `- [x] feature-name — completed YYYY-MM-DD`

7. Summarize what was done:
   - Feature closed: [feature name]
   - Branch: [branch name]
   - Roadmap and status updated

8. Remind the user:
   - Run `/review` before committing final changes
   - Open a PR when ready to merge `feature/[name]` → `main`
