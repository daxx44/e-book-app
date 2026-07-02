# Testing Guide

## Backend (RSpec)

```bash
cd backend
DATABASE_PASSWORD=postgres bundle exec rspec
DATABASE_PASSWORD=postgres bundle exec rubocop
```

### Covered

| Area | Spec file |
|------|-----------|
| Model validations, scopes, search | `spec/models/ebook_spec.rb` |
| Health endpoint | `spec/requests/api/v1/health_spec.rb` |
| Upload, list, show, search, download, delete | `spec/requests/api/v1/ebooks_spec.rb` |
| Sort parameter | `spec/requests/api/v1/ebooks_spec.rb` |
| Validation errors (missing title/file, non-PDF) | `spec/requests/api/v1/ebooks_spec.rb` |
| Soft delete excluded from list/search | `spec/requests/api/v1/ebooks_spec.rb` |

### Not covered (acceptable for assignment scope)

- Service object unit tests in isolation (covered via request specs)
- Load testing / concurrent uploads
- EPUB format (out of scope — PDF only)

## Flutter

```bash
cd mobile
flutter analyze
flutter test
```

### Widget / screen tests

| Test | File |
|------|------|
| Empty state | `test/widgets/empty_state_widget_test.dart` |
| Delete dialog | `test/widgets/delete_confirmation_dialog_test.dart` |
| Book card | `test/widgets/book_card_test.dart` |
| Cover preview | `test/widgets/cover_preview_test.dart` |
| Highlighted text | `test/widgets/highlighted_text_test.dart` |
| Loading widget | `test/widgets/loading_widget_test.dart` |
| Library screen | `test/screens/library_screen_test.dart` |
| Upload screen | `test/screens/upload_screen_test.dart` |
| Search screen | `test/screens/search_screen_test.dart` |

### Not covered

- Full integration tests against live API (manual checklist instead)
- PDF viewer rendering (Syncfusion widget; verified manually)

## Manual testing

See [MANUAL_TESTING.md](MANUAL_TESTING.md) for the full pre-submission checklist.

## CI

GitHub Actions (`.github/workflows/ci.yml`):

- Backend: `rspec` + `rubocop` with PostgreSQL service
- Flutter: `flutter analyze` + `flutter test`
