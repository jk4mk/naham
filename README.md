# NAHAM Cook App

Multi-role marketplace platform for home cooks - Frontend Application

## Architecture

- **Platform**: Flutter (iOS, Android, Web)
- **Architecture**: Clean Architecture (Feature-Based)
- **State Management**: Riverpod
- **Routing**: GoRouter

## Project Structure

```
lib/
 ├── core/
 │   ├── config/
 │   ├── constants/
 │   ├── theme/
 │   ├── routing/
 │   ├── network/
 │   ├── services/
 │   ├── utils/
 │   └── widgets/
 │
 ├── features/
 │   ├── auth/
 │   ├── home/
 │   ├── orders/
 │   ├── chat/
 │   ├── reels/
 │   ├── menu/
 │   ├── profile/
 │   ├── analytics/
 │   └── documents/
 │
 └── main.dart
```

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code (for freezed, json_serializable):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Run the app:
```bash
flutter run
```

## Development Strategy

- **Mock-First**: All features use mock repositories initially
- **Clean Architecture**: Strict separation of data, domain, and presentation layers
- **Feature-Based**: Each feature is self-contained with its own data/domain/presentation

## Code Quality

- Follow Dart style guide
- Use `flutter analyze` to check code quality
- All code must be production-ready
