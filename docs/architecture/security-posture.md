# Security Posture

This document defines standing constraints that must be preserved across all future changes.

## Constraints

- All external API calls route through a server-side proxy in production
- Sensitive tokens are never stored in `localStorage` or any other browser storage
- RLS is enabled on all user-facing database tables
- CORS never uses a wildcard origin
- Internal tracking data is excluded from outbound AI payloads
- All dev-only routes and dashboards are gated behind the `DEV` environment flag

## Rule

Any change that conflicts with one of these constraints must be redesigned before it is merged.
