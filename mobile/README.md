# Ebook Library — Flutter App

Mobile client for the Digital Ebook Library (Rails API backend).

## Stack (per MASTER_PROJECT_SPEC)

- Flutter 3 / Dart 3
- **GetX** — state, DI, navigation
- **Dio** — REST client
- Material 3
- syncfusion_flutter_pdfviewer, file_picker, path_provider

## API base URL

| Platform | URL |
|----------|-----|
| Android emulator | `http://10.0.2.2:3000/api/v1` |
| iOS simulator / desktop | `http://localhost:3000/api/v1` |

Configure in `lib/core/config/api_config.dart`.

## Run

```bash
cd mobile
flutter pub get
flutter run
```

Ensure the Rails backend is running on port 3000.

## Test

```bash
flutter test
flutter analyze
```

## Architecture

```
Screen → GetX Controller → Repository → ApiClient (Dio) → Rails API
```

See `../docs/MASTER_PROJECT_SPEC.md` Part 4 for full Flutter design.
