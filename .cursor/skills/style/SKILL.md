---
name: style
description: Enforces Luno iOS Swift coding style for UIKit modules. Use when creating or editing Swift files, view controllers, view models, protocols, properties, and function naming in this repository.
---

# Luno iOS Style

## Quick rules

1. Prefer `final class` for concrete implementations unless subclassing is required.
2. Use protocol split for inputs/outputs in view model contracts where applicable.
3. Group sections with `// MARK:` in this order: properties, init, lifecycle, setup, bind, actions, extension blocks.
4. Keep `Layout` constants in nested private enum for spacing/sizing.
5. Use explicit access control (`private`, `private(set)`, `internal`) for stored properties.
6. Prefer descriptive names: `selectedIndexPaths`, `hasCompletedInitialMediaLoad`, `showTemporaryDataAccessScreen`.

## Naming conventions

- Types: `PascalCase`
- Variables/functions: `camelCase`
- Boolean names start with `is/has/should/can`
- Protocol names describe role, e.g. `ShareMediaViewModelInputs`
- Concrete implementations use `Default*` when pattern already exists in module

## Code shape

- Keep UI property builders in closure blocks.
- Avoid long inline logic in lifecycle methods; delegate to private methods.
- Use small private helper methods for repeated logic.
- Keep comments short and only for non-obvious behavior.

## Apply checklist before finishing

- [ ] New code matches existing naming style in surrounding file.
- [ ] `MARK` grouping is consistent.
- [ ] New constants are centralized under `Layout` when UI-related.
- [ ] Access level is minimal and explicit.
