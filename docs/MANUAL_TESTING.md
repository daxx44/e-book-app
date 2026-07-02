# Manual Testing Checklist

Use this checklist before submission. Run backend (`bundle exec rails server`) and Flutter app together.

## Environment

- [ ] PostgreSQL running
- [ ] `DATABASE_PASSWORD` set
- [ ] API health: `GET /api/v1/health` returns 200
- [ ] Flutter `api_config.dart` matches your device (emulator / LAN IP / USB)

## Upload

- [ ] Open Upload screen from library FAB
- [ ] Validation: title required without file → error shown
- [ ] Validation: file required without title → error shown
- [ ] Pick valid PDF → upload succeeds → snackbar shown
- [ ] Upload non-PDF → server validation error shown
- [ ] Upload >100 MB → rejected with clear message

## Library

- [ ] Empty state when no books
- [ ] Books appear on bookshelf layout after upload
- [ ] Pull-to-refresh reloads list
- [ ] Sort by Recent / Title / Author works
- [ ] Loading spinner while fetching
- [ ] Error state + Retry when server stopped

## Search

- [ ] Idle state before typing
- [ ] Debounced search (no request per keystroke)
- [ ] Search by title returns matches
- [ ] Search by author returns matches
- [ ] Search by filename returns matches
- [ ] No results → empty state
- [ ] Match highlighting visible on cards
- [ ] Sort works on search results

## Read

- [ ] Tap book → PDF opens in reader
- [ ] Page navigation works
- [ ] Zoom (double-tap) works
- [ ] Full-screen toggle works
- [ ] Re-open book → last page remembered

## Download

- [ ] Download from library card → success snackbar
- [ ] File opens or saves on device

## Delete

- [ ] Delete shows confirmation dialog
- [ ] Cancel keeps book
- [ ] Confirm removes book from library and server
- [ ] Failure shows snackbar (e.g. server offline)

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

- [ ] All backend specs pass
- [ ] All Flutter tests pass
- [ ] No analyze errors

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
