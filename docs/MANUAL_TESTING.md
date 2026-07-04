# Manual Testing Checklist

Use before sharing the repo or submitting the assignment. Run the **Rails API** and **Flutter app** together.

**Setup reminder:** Configure `mobile/lib/core/config/api_config.dart` for your device (emulator / LAN IP / USB). See root [README.md](../README.md#3-configure-flutter-api-url).

---

## Environment

- [ ] PostgreSQL running
- [ ] `DATABASE_PASSWORD` set when starting Rails
- [ ] API health: `GET http://localhost:3000/api/v1/health` → 200
- [ ] `api_config.dart` matches your device mode
- [ ] Physical device: health URL works in phone browser (if using Wi-Fi mode)

---

## Upload

- [ ] Open Upload from library FAB
- [ ] Validation: title required without file → error shown
- [ ] Validation: file required without title → error shown
- [ ] Upload valid PDF → success → appears in library
- [ ] Upload valid EPUB → success → appears in library
- [ ] Optional cover image → shows on book card
- [ ] Upload non-PDF/EPUB → server validation error
- [ ] Upload > 100 MB → rejected with clear message

---

## Library

- [ ] Empty state when no books
- [ ] Bookshelf layout after upload
- [ ] Continue Reading strip (after reading a book)
- [ ] Pull-to-refresh reloads list
- [ ] Sort by Recent / Title / Author
- [ ] Loading shimmer while fetching
- [ ] Server stopped → themed “server unavailable” + Try again
- [ ] Generic error + Retry for other failures

---

## Search

- [ ] Idle state before typing
- [ ] Debounced search (not every keystroke)
- [ ] Search by title, author, filename
- [ ] No results → empty state
- [ ] Match highlighting on cards
- [ ] Sort on search results
- [ ] File-type quick filters (PDF / EPUB)

---

## Read

- [ ] PDF opens in reader
- [ ] EPUB opens in reader
- [ ] Page / chapter navigation
- [ ] PDF zoom (double-tap)
- [ ] Reading settings (font size for EPUB)
- [ ] Re-open book → last position remembered
- [ ] Progress footer shows page / percent

---

## Download

- [ ] Download from library → progress sheet
- [ ] Book appears in **Downloads** tab
- [ ] Read downloaded book offline (local file)
- [ ] Remove download from Downloads tab

---

## Delete

- [ ] Delete shows confirmation dialog
- [ ] Cancel keeps book
- [ ] Confirm removes from library and server
- [ ] Failure snackbar when server offline

---

## Dashboard & About

- [ ] Bottom nav: Library, Downloads, About
- [ ] About shows app name and developer info

---

## Automated tests

```powershell
# Backend
cd backend
$env:DATABASE_PASSWORD = "postgres"
bundle exec rspec
bundle exec rubocop

# Flutter
cd mobile
flutter analyze
flutter test
```

- [ ] RSpec: 42 examples, 0 failures
- [ ] Flutter: all tests pass
- [ ] `flutter analyze`: no issues

See [test-results/TEST_RUN_OUTPUT.md](test-results/TEST_RUN_OUTPUT.md) for sample output.

---

## Demo capture (submission)

Record or screenshot:

1. Empty library
2. Upload flow (PDF or EPUB)
3. Bookshelf with books + Continue Reading
4. Search with highlights
5. Reader (PDF or EPUB)
6. Downloads tab with offline book
7. Delete confirmation
8. Terminal: `rspec` + `flutter test` passing

Save to `docs/screenshots/` — see [screenshots/README.md](screenshots/README.md).
