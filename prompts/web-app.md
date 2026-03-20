# Web App — System Prompt

## When to use this
Use this prompt for frontend or fullstack web applications — React, Vue, Svelte, Next.js, Remix, or similar. Works for both pure frontend SPAs and fullstack apps with a server component.

---

## Project Context Injection

Before starting, read and internalize:
1. `CLAUDE.md` — constraints, commands, and development workflow
2. `docs/CURRENT_STATUS.md` — what's been built and what's in progress
3. `docs/ACTIVE_ROADMAP.md` — current priorities
4. `docs/ONBOARDING.md` — project overview and key locations

---

## Coding Style Rules

- Use functional components and hooks — no class components
- Co-locate component state as close to where it's used as possible
- Keep components small and focused on a single responsibility
- Use TypeScript interfaces for all props and API response types
- Avoid `as any` — use proper types or runtime validation (Zod)
- Use named exports, not default exports, unless the framework requires it
- CSS: use whatever system is already in the project (Tailwind, CSS modules, styled-components)

---

## Preferred Libraries

**Frontend**
- React / Next.js / Remix (use what's in the project)
- Tailwind CSS for styling
- Zod for runtime validation of API responses and form inputs
- React Query / SWR for data fetching and caching

**Backend (if fullstack)**
- Hono or Fastify for API routes (prefer over Express for new projects)
- Drizzle or Prisma for database access
- Zod for request body validation

**Testing**
- Vitest or Jest for unit/integration tests
- Playwright for end-to-end tests

---

## Error Handling Conventions

- Every `fetch` or API call must have a `try/catch` — never let network failures crash silently
- UI components must handle loading, error, and empty states explicitly
- Never expose raw server error messages to the user — show a generic message, log the detail
- Server-side: always return a consistent error shape `{ error: string, code?: string }`
- Use HTTP status codes correctly: 4xx for client errors, 5xx for server errors
- Never use CORS wildcard (`*`) on internal API routes — restrict to known origins

---

## Notes for Claude Code

- Run `/context` at the start of a session to re-orient quickly
- Check `docs/ACTIVE_ROADMAP.md` before starting any new feature
- Log bugs with `/bug [description]` — don't fix and move on silently
- Run `/review` before committing — check for exposed API keys and unvalidated inputs
- Document library choices in `docs/DECISIONS.md` with reasoning
