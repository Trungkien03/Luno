---
name: observable-binding
description: Applies safe Observable binding patterns used in Luno iOS. Use when observing view model state, handling async callbacks, and preventing retain cycles or post-deinit crashes.
---

# Luno Observable Binding Safety

## Binding rules

1. Always capture `[weak self]` in observe/callback closures.
2. Use `guard let self else { return }` early in closure body.
3. Update UI on main thread when binding source may come from async background work.
4. Remove observers in `deinit` when observer API requires manual cleanup.
5. Avoid duplicate observer registration in repeated lifecycle paths.

## Async callback rules

- Set loading flags before request and reset in all completion branches.
- Handle `Result` with explicit `success` and `failure`.
- Surface user-safe error messages through output observables.
- Guard required IDs or params early and return quickly if invalid.

## Crash-prevention checklist

- [ ] No strong capture of view/view controller in long-lived closure.
- [ ] Observer removal exists for manually managed observer APIs.
- [ ] Empty/invalid state handling is explicit.
- [ ] Loading state cannot get stuck on `true` after failure.
