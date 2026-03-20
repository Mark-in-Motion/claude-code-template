# Review

Run the security gate checklist against staged changes before committing.

1. Run `git status` to see what's staged and unstaged
2. Run `git diff --cached` to see the exact staged diff

3. Scan the diff for each of the following and report findings:

**Secrets & API keys**
- Strings matching key prefixes: `sk-`, `ghp_`, `xoxb-`, `AIza`, `AKIA`
- Literal assignments: `password =`, `secret =`, `api_key =`, `token =`
- Any `.env` files appearing in the staged changes

**Injection & input validation**
- Raw SQL string concatenation (e.g., query built by `+` or f-string with a variable)
- `eval()` called with a non-literal argument
- `req.body`, `request.json()`, or similar passed directly to a database call without validation
- Shell command strings built from user input

**File system**
- `../` appearing in any string that looks like a file path derived from user input
- File writes to paths constructed from external data

**Error handling**
- `fetch`, `axios`, database calls, or external API calls without a surrounding `try/catch`
- `await` calls without error handling
- Functions that return `null` or `undefined` silently on failure

**TypeScript**
- `as any` on external API response types

4. Report findings grouped by category:
   - **Clean** — nothing found in this category
   - **Warning** — potential issue, worth reviewing
   - **Issue** — likely problem that should be fixed before committing

5. Summarize: "X issues, Y warnings found." and ask:
   "Ready to commit, or do you want to address something first?"

This command is read-only. It does not modify any files or run any git commands other than `git status` and `git diff --cached`.
