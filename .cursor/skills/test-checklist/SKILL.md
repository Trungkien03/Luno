---
name: test-checklist
description: Supplies manual test checklist for Luno iOS UIKit features. Use when validating feature changes, bugfixes, selection UI, filter/sort behavior, sharing flows, and pagination updates.
---

# Luno iOS Test Checklist

## Core UI states

- [ ] Initial loading state appears and exits correctly.
- [ ] Empty state appears only when data truly empty.
- [ ] Error state/toast appears on failure paths.
- [ ] Success state updates UI without stale content.

## Selection and list behavior

- [ ] Single select: choose, re-choose, clear, confirm CTA enable/disable.
- [ ] Multi select: add/remove multiple items, reset behavior.
- [ ] Search filtering preserves correct selected item mapping.
- [ ] Duplicate item names do not break selection.

## Async and pagination

- [ ] Pull/load-more does not duplicate or skip items.
- [ ] Pagination loader visibility toggles correctly.
- [ ] Rapid repeated actions do not create inconsistent UI state.

## Sharing/access flow

- [ ] Permission fetch with valid resource ID works.
- [ ] Invalid resource guard prevents invalid request side effects.
- [ ] Access options and selected users persist as intended after updates.
