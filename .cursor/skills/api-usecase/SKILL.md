---
name: api-usecase
description: Follows Luno use-case based networking flow in view models. Use when adding API calls, request DTO mapping, cancellable tasks, loading/error state, and permission or share workflows.
---

# Luno API + UseCase Pattern

## Request flow

1. Validate required IDs/inputs via `guard`.
2. Set `loading.value = true`.
3. Execute use case with DTO request model.
4. Store returned `Cancellable` if call can overlap/retry.
5. Reset loading in completion and handle result branches.

## State update conventions

- Convert domain response into view model state, not directly into UI operations.
- Emit updates through observable outputs.
- Keep temporary local cache structures when needed for mapping (example: metadata by key).

## Cancellation rules

- Keep one task property per API concern.
- Replace old task reference when issuing a new request for same concern.
- Clear or ignore stale results if they conflict with latest user intent.

## Error handling

- Use `error.value = error.localizedDescription` for user-facing fallback.
- Avoid swallowing failures silently unless behavior intentionally best-effort.
