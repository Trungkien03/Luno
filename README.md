# Luno iOS

A clean-architecture iOS app built as a learning/reference project demonstrating modern Swift patterns.

## Overview

**Luno** is a modular iOS application structured around **Clean Architecture**, **MVVM**, and the **Coordinator** pattern. It currently ships two main features — a Chat module and a Settings module — and is designed to scale easily by adding new modules without touching existing ones.

## Architecture

| Layer | Folder | Role |
|---|---|---|
| Application | `Luno/Application/` | Entry point, DI containers, flow coordinators |
| Presentation | `Luno/Presentation/` | View controllers + ViewModels (MVVM) |
| Infrastructure | `Luno/Infrastructure/` | Network client, WebSocket |
| Data | `Luno/Data/` | Repository implementations, utilities |

> For a detailed breakdown of every layer, file, and pattern, see [GIIS_iOS_Architecture.md](./GIIS_iOS_Architecture.md).

## Features

- 💬 **Chat** – Chat list and detail screens
- ⚙️ **Settings** – Profile and theme preferences
  - Light / Dark / System theme switching via `ThemeManager`
  - Grouped settings sections (easily extensible)

## Tech Stack

| Tool | Usage |
|---|---|
| Swift 5 | Language |
| UIKit | UI framework (programmatic, no Storyboards) |
| SnapKit | Auto-layout DSL |
| Core Data | Local persistence |
| SPM | Dependency management |

## Key Patterns

- **Coordinator** – navigation is fully decoupled from view controllers via typed `NavigationTarget` enums and `Actions` closure structs
- **MVVM** – ViewModels expose state through a lightweight `Observable<T>` (no Combine/RxSwift dependency)
- **DI Containers** – each module owns its own `*DIContainer` that constructs repositories, use cases, and view models
- **ThemeManager** – reactive singleton (`Observable<AppTheme>`) that applies `overrideUserInterfaceStyle` app-wide

## Project Structure

```
iOS_CleanArchitecture/
├── Luno/                    # Main source
│   ├── Application/         # SceneDelegate, AppFlowCoordinator, DI, Flows
│   ├── Presentation/        # Chat/, Settings/ (View + ViewModel)
│   ├── Infrastructure/      # Network/, WebSocket/
│   ├── Data/                # Utils/
│   └── Observable.swift     # Shared reactive primitive
├── Luno.xcodeproj
├── LunoTests/
└── LunoUITests/
```

## Getting Started

1. Clone the repository
2. Open `Luno.xcodeproj` in Xcode 15+
3. Add `ApiBaseURL` to `Info.plist` (or update `AppConfiguration.swift`)
4. Select a simulator and run ▶
