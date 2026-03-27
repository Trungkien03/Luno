---
name: feature-mvvm
description: Guides feature implementation in Luno iOS using UIKit plus MVVM and use case driven flow. Use when adding screens, new user flows, or extending existing app features.
---

# Luno iOS Feature MVVM Flow

## Standard workflow

1. Define or extend view model protocols (`Inputs`, `Outputs`, combined protocol).
2. Add observable outputs for UI states (`loading`, `error`, `successMessage`, data lists).
3. Inject dependencies through initializer (actions, use cases).
4. Keep navigation in actions closures from view model to coordinator/router layer.
5. Bind view model outputs in view/view controller using weak self.

## ViewModel contract pattern

- Inputs contain user intents and data fetch methods.
- Outputs contain observable states and public view data.
- Concrete view model contains task references for cancellable API calls.

## UI integration pattern

- VC/View owns `setupUI()`, `bind()`, action handlers.
- VC should not call data layer directly.
- VC reads from view model outputs and triggers view model inputs.

## Add feature safely

- Add new behavior as a focused method, not by expanding an unrelated giant method.
- Preserve existing flow state flags if screen already uses initial/pagination/loading guards.
- Prefer extending existing enums/models for options/filtering instead of ad-hoc strings.
