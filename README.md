# claude-code-template

[![CI](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/ci.yml/badge.svg)](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/ci.yml)
[![Lint](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/lint.yml/badge.svg)](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/lint.yml)
[![CodeQL](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/codeql.yml/badge.svg)](https://github.com/Mark-in-Motion/claude-code-template/actions/workflows/codeql.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A GitHub template for starting any software project with Claude Code integration, session-based documentation, and cross-platform setup built in from day one.

> Clone it, run setup, and start building your actual idea — not the infrastructure.

---

## Which system prompt should I use?

Pick the prompt from `prompts/` that matches your project type and reference it when starting a Claude session:

| My project is... | Use this prompt |
|---|---|
| A web app (frontend or fullstack) | `prompts/web-app.md` |
| A backend API | `prompts/api-service.md` |
| A command-line tool | `prompts/cli-tool.md` |
| A data or ML pipeline | `prompts/data-pipeline.md` |
| Something else | `prompts/general.md` |

---

## Quick Start

### Option 1: GitHub Template
1. Click **Use this template** on GitHub
2. Clone your new repo
3. Run the setup script from the repo root

### Option 2: Clone directly
**Mac**
```bash
git clone https://github.com/Mark-in-Motion/claude-code-template.git your-project-name
cd your-project-name
rm -rf .git
./scripts/setup.sh
```

**Windows**
```bat
git clone https://github.com/Mark-in-Motion/claude-code-template.git your-project-name
cd your-project-name
rmdir /s /q .git
scripts\setup.bat
```

### Setup flags
```bash
./scripts/setup.sh             # Interactive setup
./scripts/setup.sh --dry-run   # Preview substitutions before applying
```

---

## Using with Claude Code

After cloning the template, open a terminal in the repo root and run the setup script first so all `{{PLACEHOLDER}}` tokens are replaced with your project details.

**Mac**
```bash
cd your-project-name
./scripts/setup.sh
```

**Windows**

```bat
cd your-project-name
scripts\setup.bat
```

Then open Claude Code from the repository root and start with:

```text
/orient
```

`/orient` reads the onboarding docs, loads the prompt that matches your project type, summarizes the repo structure, and waits for your confirmation before creating or changing anything.

Typical flow:
1. Clone the template
2. Open a terminal in the cloned folder
3. Run the setup script for your platform
4. Open Claude Code from the repo root
5. Run `/orient`
6. Confirm the first thing you want built
7. Create or place a blueprint in `docs/blueprints/`
8. Ask Claude Code to read the blueprint and then start implementation

---

## What the setup script does

1. Prompts for: project name, description, type, team size, tech stack, and deployment target
2. Substitutes all `{{PLACEHOLDER}}` tokens across the template files
3. Creates a starter source file for your stack
4. Validates that no placeholders were missed
5. Optionally runs `git init` and makes the initial commit

---

## Template Structure

```
claude-code-template/
│
├── CLAUDE.md                          # Claude Code instructions, constraints, workflow
├── CONTRIBUTING.md                    # How to extend this template
├── LICENSE                            # MIT
├── README.md                          # This file
├── .env.example                       # Environment variable template
├── package.json                       # Node.js starter config
├── requirements.txt                   # Python starter dependencies
├── tsconfig.json                      # TypeScript config
│
├── .claude/
│   ├── commands/
│   │   ├── new-session.md             # /new-session — start a dated session file
│   │   ├── update-status.md           # /update-status — summarize current state
│   │   ├── context.md                 # /context — compact re-orientation dump
│   │   ├── start-feature.md           # /start-feature [name] — branch + session + roadmap
│   │   ├── close-feature.md           # /close-feature — archive + mark complete
│   │   ├── bug.md                     # /bug [desc] — log to docs/bugs.md
│   │   ├── checkpoint.md              # /checkpoint — snapshot status + roadmap
│   │   └── review.md                  # /review — security gate before commit
│   ├── settings.json                  # Shared hooks (destructive-op warnings, lint-on-save)
│   ├── settings.local.json            # Machine-specific overrides (gitignored)
│   └── settings.local.json.example   # Example of local overrides
│
├── prompts/
│   ├── general.md                     # Default catch-all system prompt
│   ├── web-app.md                     # Frontend/fullstack web apps
│   ├── api-service.md                 # Backend APIs
│   ├── cli-tool.md                    # Command-line tools
│   └── data-pipeline.md               # Data and ML projects
│
├── docs/
│   ├── PROJECT_CONTEXT.md             # Architecture, tech stack, goals
│   ├── CURRENT_STATUS.md              # Real-time dev progress
│   ├── ACTIVE_ROADMAP.md              # Prioritized feature plan
│   ├── DECISIONS.md                   # ADR log — why decisions were made
│   ├── KNOWN_ISSUES.md                # Accepted limitations and trade-offs
│   ├── ONBOARDING.md                  # 5-minute onboarding for new devs or Claude
│   ├── bugs.md                        # Reported bug log (written by /bug command)
│   ├── sessions/
│   │   └── latest-session.md          # Session template (Goal / Done / Blockers / Next)
│   ├── completed/                     # Archived sessions and checkpoints
│   └── reference/
│       └── skills-examples.md         # Guide for writing custom slash commands
│
├── src/                               # Application source code
├── public/                            # Static assets
│
├── scripts/
│   ├── setup.sh                       # Unix/Mac setup (supports --dry-run)
│   └── setup.bat                      # Windows setup (full parity with setup.sh)
│
└── .github/
    └── workflows/
        ├── ci.yml                     # Full CI — Node, Python, Go, Rust (comment in your stack)
        ├── lint.yml                   # Lint on every push to every branch
        └── deploy.yml                 # Deployment placeholder — Vercel, Railway, Fly.io
```

---

## Claude Code Integration

### Custom Slash Commands

| Command | What it does |
|---|---|
| `/new-session` | Creates a dated session file, asks for your goal |
| `/update-status` | Reads git log + CURRENT_STATUS.md, summarizes state |
| `/context` | Compact read-only dump for re-orienting mid-session |
| `/start-feature [name]` | Creates feature branch, session file, updates roadmap |
| `/close-feature` | Archives session, marks feature done in status + roadmap |
| `/bug [description]` | Appends bug entry to `docs/bugs.md` |
| `/checkpoint` | Snapshots status + roadmap to dated archive, optional commit |
| `/review` | Runs security gate checklist against staged changes |

### Hooks
Three hooks are pre-configured in `.claude/settings.json`:
- **Destructive bash warning** — fires before `rm -rf` and similar commands
- **File overwrite warning** — fires when writing to a file that already has content
- **Last-modified log** — timestamps file changes to `docs/.last-modified`

Add your lint-on-save command to the fourth hook slot in `settings.json`.

### Session Workflow
```
/new-session → develop → /bug [if needed] → /checkpoint → /review → commit
```

---

## Stack Support

The setup script auto-configures commands for:

| Stack | Build | Start | Test | Lint |
|---|---|---|---|---|
| Node.js | `npm run build` | `node --watch src/` | `npm test` | `npm run lint` |
| Node.js + TS | `tsc` | `node --watch --experimental-strip-types` | `npm test` | `npm run lint` |
| Python | `pip install -e .` | `python app.py` | `python -m pytest` | `python -m ruff check .` |
| Go | `go build` | `go run main.go` | `go test ./...` | `go fmt ./...` |
| Rust | `cargo build` | `cargo run` | `cargo test` | `cargo clippy` |
| Custom | prompted | prompted | prompted | prompted |

---

## Built with this template

*Nothing here yet — yours could be first.*

If you built something with this template, open a PR to add it here.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add stack support, new slash commands, or new placeholder tokens.

## License

MIT — see [LICENSE](LICENSE).
