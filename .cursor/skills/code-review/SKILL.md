---
name: code-review
description: Reviews Luno iOS Swift changes for regressions, architecture fit, and safety. Use when reviewing pull requests, large Swift edits, feature module changes, or when user asks for a code review.
---

# Luno iOS Code Review

## Review priorities

1. Correctness and runtime safety (crash risk, index/state mismatch).
2. Memory/lifecycle safety (`weak self`, observer cleanup, deinit behavior).
3. MVVM boundary integrity (no data-layer logic leaked into view code).
4. UI state consistency (loading, empty, error, success transitions).
5. Naming/style consistency with surrounding Luno code.

## High-signal checks

- Async completion always handles both `success` and `failure`.
- Loading flags are reset on all code paths.
- Table/collection selection uses stable source index mapping.
- Feature flags/booleans remain coherent across flow branches.
- Public API surface of view models remains backward compatible unless intended.

## Feedback format

- `Critical`: Must fix before merge.
- `Risk`: Could cause bugs/regressions; recommend fix.
- `Suggestion`: Readability/maintainability improvement.
