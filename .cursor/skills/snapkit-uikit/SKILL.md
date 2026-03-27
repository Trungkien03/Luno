---
name: snapkit-uikit
description: Implements UIKit views with SnapKit following Luno UI composition style. Use when creating custom views, table/collection screens, state placeholders, and bottom action bars.
---

# Luno UIKit + SnapKit

## UI composition pattern

1. Build UI components as lazy/private properties.
2. Keep style setup close to component creation.
3. Separate `setupUI`, `setupConstraints`, and `bind` methods.
4. Centralize spacing constants in local `Layout` enum.
5. Use dedicated placeholder views for empty/loading/no-result states.

## Table/collection conventions

- Register cells during table/collection setup.
- Keep row/item height constants in `Layout`.
- Reload and update empty state in one place after data changes.
- For filtered lists, maintain index mapping when source has duplicate labels.

## Interaction conventions

- Expose callback closures (`confirmButtonAction`, `onOptionSelected`) for parent integration.
- Keep selection state in private(set) properties when needed externally read-only.
- Enable/disable CTA buttons from derived selection state.
