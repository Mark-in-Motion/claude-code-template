# Orient

Start a brand-new project session by reading the template guidance, loading the right prompt, and asking the user what to build before changing anything.

This command is read-only. Do not create, edit, or move files.

1. Read `CLAUDE.md`
2. Read `docs/ONBOARDING.md`
3. Extract `{{PROJECT_TYPE}}` from `CLAUDE.md`
4. Choose the matching prompt file from `prompts/`:
   - Web app, frontend, or fullstack web project -> `prompts/web-app.md`
   - Backend API -> `prompts/api-service.md`
   - Command-line tool -> `prompts/cli-tool.md`
   - Data or ML pipeline -> `prompts/data-pipeline.md`
   - Anything else or unclear -> `prompts/general.md`
5. Read the chosen prompt file
6. Summarize, in a concise response:
   - the project type
   - the repo’s key entry points and docs workflow from `docs/ONBOARDING.md`
   - the conventions loaded from the selected prompt
   - the safest first-step sequence: clone -> run setup script -> open Claude Code -> orient -> confirm -> build
7. Ask exactly one question: "What are we building first?"

Do not create files, do not suggest implementation details beyond the first-step sequence, and do not continue into planning until the user answers.
