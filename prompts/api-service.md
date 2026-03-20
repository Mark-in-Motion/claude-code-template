# API Service — System Prompt

## When to use this
Use this prompt for backend-only REST or GraphQL APIs. Suitable for microservices, standalone API servers, and backend-for-frontend layers.

---

## Project Context Injection

Before starting, read and internalize:
1. `CLAUDE.md` — constraints, commands, and development workflow
2. `docs/CURRENT_STATUS.md` — what's been built and what's in progress
3. `docs/ACTIVE_ROADMAP.md` — current priorities
4. `docs/ONBOARDING.md` — project overview and key locations

---

## Coding Style Rules

- Keep route handlers thin — move business logic into service or domain functions
- Validate all incoming request data at the boundary (before it touches business logic)
- Never pass raw `req.body` or `request.json()` directly to a database query
- Return consistent response shapes — success and error responses should follow the same structure
- Use HTTP status codes correctly: 200/201 for success, 400/422 for client errors, 500 for server errors
- Document all endpoints (inline comments or OpenAPI spec)

---

## Preferred Libraries

**Node.js**
- Hono or Fastify (prefer over Express for new services — better TypeScript support and performance)
- Zod for request validation
- Drizzle or Prisma for database access

**Python**
- FastAPI (automatic OpenAPI docs, Pydantic validation built in)
- SQLAlchemy or SQLModel for database access

**Go**
- Gin or Echo for routing
- GORM or sqlx for database access

**Testing**
- Unit test service/domain logic in isolation from HTTP handlers
- Integration test routes against a real (test) database — do not mock the database

---

## Error Handling Conventions

- Every database call and external service call needs error handling
- Log errors server-side before responding — never silently return null
- Return a consistent error shape: `{ error: string, code?: string }` — never expose stack traces
- Use a global error handler middleware to catch unhandled errors
- Validate inputs with a schema library (Zod, Pydantic) — reject with 400 before touching business logic
- Rate limiting and auth checks should happen in middleware, not inside route handlers

---

## Notes for Claude Code

- Run `/context` at the start of a session to re-orient quickly
- Check `docs/ACTIVE_ROADMAP.md` before starting any new endpoint
- Log bugs with `/bug [description]`
- Run `/review` before committing — check for SQL injection, unvalidated inputs, and exposed secrets
- Document any API design decisions in `docs/DECISIONS.md`
