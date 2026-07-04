# Manual Testing Checklist

Use this checklist before submission. Run backend (`bundle exec rails server`) and Flutter app together.

## Environment

- [x] PostgreSQL running
- [x] `DATABASE_PASSWORD` set
- [x] API health: `GET /api/v1/health` returns 200
- [x] Flutter `api_config.dart` matches your device (emulator / LAN IP / USB)

## Upload

- [x] Open Upload screen from library FAB
- [x] Validation: title required without file → error shown
- [x] Validation: file required without title → error shown
- [x] Pick valid PDF → upload succeeds → snackbar shown
- [x] Upload non-PDF → server validation error shown
- [x] Upload >100 MB → rejected with clear message



## Library

- [x] Empty state when no books
- [x] Books appear on bookshelf layout after upload
- [x] Pull-to-refresh reloads list
- [x] Sort by Recent / Title / Author works
- [x] Loading spinner while fetching
- [x] Error state + Retry when server stopped



## Search

- [x] Idle state before typing
- [x] Debounced search (no request per keystroke)
- [x] Search by title returns matches
- [x] Search by author returns matches
- [x] Search by filename returns matches
- [x] No results → empty state
- [x] Match highlighting visible on cards
- [x] Sort works on search results



## Read

- [x] Tap book → PDF opens in reader
- [x] Page navigation works
- [x] Zoom (double-tap) works
- [x] Full-screen toggle works
- [x] Re-open book → last page remembered



## Download

- [x] Download from library card → success snackbar
- [x] File opens or saves on device



## Delete

- [x] Delete shows confirmation dialog
- [x] Cancel keeps book
- [x] Confirm removes book from library and server
- [x] Failure shows snackbar (e.g. server offline)



## Automated tests

```powershell
# Backend
cd backend
bundle exec rspec
bundle exec rubocop

# Flutter
cd mobile
flutter analyze
flutter test
```

- [x] All backend specs pass
- [x] All Flutter tests pass
- [x] No analyze errors



## Demo capture (submission)

Record or screenshot:

1. Empty library
2. Upload flow
3. Bookshelf with books
4. Search with highlights
5. PDF reader (full screen)
6. Download success
7. Delete confirmation
8. Test run output (`rspec` + `flutter test`)

Save screenshots to `docs/screenshots/` (create folder when capturing).