# Onboarding — Get Up to Speed in 5 Minutes

Whether you're a new developer joining this project or Claude Code starting a fresh session, this file is your entry point.

---

## What is this project?

**Type:** {{PROJECT_TYPE}}

**In one line:** {{PROJECT_DESCRIPTION}}

**Team:** {{TEAM_SIZE}}

---

## How to run it locally

```bash
# 1. Install dependencies
{{BUILD_COMMAND}}

# 2. Copy environment variables
cp .env.example .env
# Edit .env and fill in your values

# 3. Start the development server
{{START_COMMAND}}
```

---

## Where is everything?

| Path | What it is |
|------|-----------|
| `src/` | Application source code |
| `public/` | Static assets |
| `scripts/` | Setup and utility scripts |
| `prompts/` | System prompts — pick the one matching this project type |
| `docs/CURRENT_STATUS.md` | What's built, what's in progress, what's blocked |
| `docs/ACTIVE_ROADMAP.md` | Prioritized feature plan |
| `docs/DECISIONS.md` | Why key decisions were made |
| `docs/KNOWN_ISSUES.md` | Structural limitations we're living with |
| `docs/bugs.md` | Reported bugs log |
| `docs/sessions/` | Development session logs |
| `.claude/commands/` | Custom Claude Code slash commands |
| `CLAUDE.md` | Claude Code instructions and constraints |

---

## What's being worked on right now?

Read `docs/CURRENT_STATUS.md` for the latest.

---

## What's the plan?

Read `docs/ACTIVE_ROADMAP.md` for the prioritized feature list and milestones.

---

## Key decisions already made

Read `docs/DECISIONS.md` for the architectural choices and their reasoning.

---

## Known issues to be aware of

Read `docs/KNOWN_ISSUES.md` before building anything that touches known problem areas.

---

## How development sessions work

1. Run `/new-session` to create a dated session file with your goal
2. Work — update the session file as you go
3. Run `/checkpoint` before finishing to snapshot current state
4. Run `/review` before any commit to check for security issues
5. Update `docs/CURRENT_STATUS.md` to reflect what changed

---

<!-- Update this file when the project setup or key locations change. -->
