# Screenshots for submission

Add PNG or JPG captures here before submitting the assignment.

Reference these in the root [README.md](../README.md#screenshots).

## Required captures

| File | Description |
|------|-------------|
| `01-empty-library.png` | Empty state with upload CTA |
| `02-upload.png` | Upload form with PDF/EPUB selected |
| `03-bookshelf.png` | Library bookshelf + Continue Reading |
| `04-search.png` | Search results with highlighting |
| `05-reader.png` | In-app PDF or EPUB reader |
| `06-delete-dialog.png` | Delete confirmation |
| `07-tests.png` | Terminal showing `rspec` and `flutter test` passing |

## Recommended extras

| File | Description |
|------|-------------|
| `08-downloads.png` | Downloads tab with offline book |
| `09-server-down.png` | Server unavailable state on library |
| `10-about.png` | About tab |

## How to capture `07-tests.png`

**Terminal 1:**

```powershell
cd backend
$env:DATABASE_PASSWORD = "postgres"
bundle exec rspec
```

**Terminal 2:**

```powershell
cd mobile
flutter test
```

Screenshot both windows showing `0 failures` and `All tests passed!`.

You can also paste text output into [test-results/TEST_RUN_OUTPUT.md](../test-results/TEST_RUN_OUTPUT.md) (already includes a sample run from 4 Jul 2026).

## Optional

- Short demo video (link in README)
- Physical device photo showing app + health URL in browser
