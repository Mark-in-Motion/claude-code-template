# Decision Log

A lightweight record of significant architectural and design decisions. The goal is not a full ADR format — just enough to remember *why* a choice was made so future-you (or a new contributor) doesn't revisit it without context.

## Format

Each entry: date · decision · why · alternatives considered · consequence going forward.

---

## [YYYY-MM-DD] Example: Chose X over Y

**Decision:** Used X for data validation instead of Y.

**Why:** Y required a separate runtime step and didn't integrate cleanly with the existing framework. X provides compile-time guarantees with no extra setup.

**Alternatives considered:** Y (rejected — extra complexity), Z (rejected — too opinionated for this use case).

**Consequence:** All external data must be validated through X schemas at the boundary. No raw unvalidated data should flow into business logic.

---

<!-- Add new decisions above this line, most recent first -->
