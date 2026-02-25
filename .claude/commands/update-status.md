# Update Project Status

Summarize the current project state by:

1. Reading `docs/CURRENT_STATUS.md`
2. Running `git log --oneline -20` to see recent commits
3. Listing any open session files in `docs/sessions/` (most recent first)

Then provide a concise summary in this format:

```
## Current Status Summary

**Last Updated:** [date from CURRENT_STATUS.md]

**Recent Work** (from git log):
- [bullet points of recent commits, grouped by feature/area]

**Status:**
[2-3 sentences on what's working, what's in progress, and what's next]

**Immediate Next Step:**
[Single most important thing to do next]
```

After summarizing, ask: "Would you like to update CURRENT_STATUS.md with any new information?"
If yes, make the targeted edits to keep it current.
