---
name: bugfix-safe
description: Provides safe bugfix workflow for Luno iOS modules. Use when fixing crashes, wrong selection behavior, pagination issues, observer lifecycle bugs, or asynchronous UI state regressions.
---

# Luno Bugfix Safe Workflow

## Fix sequence

1. Reproduce and isolate the exact failing path.
2. Add guardrails first (nil checks, bounds checks, lifecycle checks).
3. Keep patch minimal and localized to the faulty behavior.
4. Verify no regression in adjacent flows (selection mode, loading state, pagination, observer lifecycle).
5. Preserve existing naming and architectural boundaries.

## Common bug classes in this codebase

- Duplicate row titles causing wrong selected item mapping.
- Callback after deallocation due to missing weak capture or observer cleanup.
- Loading/empty state mismatch after async completion.
- Flags not reset when request fails.

## Before finalizing

- [ ] Crash path is blocked.
- [ ] Selected item/index mapping remains stable.
- [ ] No new retain-cycle risk.
- [ ] Behavior unchanged for unaffected modes.
