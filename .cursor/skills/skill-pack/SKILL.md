---
name: skill-pack
description: Entry skill for Luno iOS engineering conventions. Use when working on Swift UIKit code to load the right Luno skills for style, MVVM flow, API handling, bugfix safety, review, and testing.
---

# Luno iOS Skill Pack

## Skill routing

When a task starts, load matching skill(s):

- Style and naming -> `../style/SKILL.md`
- New feature flow -> `../feature-mvvm/SKILL.md`
- Observable binding and async safety -> `../observable-binding/SKILL.md`
- UIKit/SnapKit view work -> `../snapkit-uikit/SKILL.md`
- API/use case integration -> `../api-usecase/SKILL.md`
- Bugfix and crash safety -> `../bugfix-safe/SKILL.md`
- Review requests -> `../code-review/SKILL.md`
- Validation/testing -> `../test-checklist/SKILL.md`

## Usage rule

For medium or large changes, combine at least:

1. one architecture/style skill
2. one safety skill
3. one verification skill
