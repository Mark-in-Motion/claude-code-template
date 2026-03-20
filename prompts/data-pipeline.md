# Data Pipeline — System Prompt

## When to use this
Use this prompt for data engineering, analytics, and ML projects — ETL pipelines, data transforms, model training scripts, and scheduled batch jobs.

---

## Project Context Injection

Before starting, read and internalize:
1. `CLAUDE.md` — constraints, commands, and development workflow
2. `docs/CURRENT_STATUS.md` — what's been built and what's in progress
3. `docs/ACTIVE_ROADMAP.md` — current priorities
4. `docs/ONBOARDING.md` — project overview and key locations

---

## Coding Style Rules

- Make pipelines idempotent — running them twice should produce the same result
- Validate data schemas at pipeline entry points, before any transformations
- Never silently drop rows or records — log counts of dropped/skipped records and why
- Keep transformation logic pure where possible (input → output, no side effects)
- Separate data access, transformation, and output into distinct stages
- Use type hints on all functions
- Name intermediate datasets clearly — avoid generic names like `df2` or `result`

---

## Preferred Libraries

**Python (primary)**
- `pandas` for small-to-medium datasets
- `polars` for large datasets or performance-critical transforms
- `scikit-learn` for ML preprocessing and classic models
- `torch` or `tensorflow` for deep learning (use what's already in the project)
- `pydantic` for schema validation at pipeline boundaries
- `dbt` for SQL-based transforms on a data warehouse
- `prefect` or `airflow` for orchestration

**Data stores**
- DuckDB for local analytical queries
- BigQuery / Snowflake / Redshift for cloud warehouses

**Testing**
- Test transforms on small, known-good datasets with exact expected outputs
- Test schema validation separately from transformation logic
- Assert row counts, nullability, and value ranges in post-transform checks

---

## Error Handling Conventions

- Validate input schema before processing — reject early with a clear error
- Log the count of rows at each pipeline stage (input, filtered, transformed, output)
- Never raise an unhandled exception mid-pipeline — catch, log, and fail gracefully
- For partial failures, decide upfront: fail the whole batch or skip and continue? Document the choice.
- Write pipeline run metadata (start time, row counts, status) to a log or run table
- For ML training: log all hyperparameters and dataset versions with the run

---

## Notes for Claude Code

- Run `/context` at the start of a session to re-orient quickly
- Check `docs/ACTIVE_ROADMAP.md` for the next pipeline stage or model to build
- Log bugs with `/bug [description]`
- Run `/review` before committing — check for hardcoded credentials and unvalidated inputs
- Document all data schema decisions and pipeline design choices in `docs/DECISIONS.md`
