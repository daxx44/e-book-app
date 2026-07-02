# Digital Ebook Library

Full-stack ebook library for uploading, browsing, searching, reading, downloading, and deleting PDF ebooks.

| Layer | Stack |
|-------|--------|
| Backend | Ruby 3.3+, Rails 8 API, PostgreSQL, Active Storage |
| Mobile | Flutter 3, GetX, Dio, Syncfusion PDF viewer |

**Assignment:** Sagar Fab International Company — Digital Ebook Library

---

## Project structure

```
E-Book app/
├── backend/          # Rails 8 API-only app
├── mobile/           # Flutter client (package name: frontend)
└── docs/             # Spec, API, architecture, testing
```

---

## Prerequisites

### Backend

- [Ruby 3.3+](https://rubyinstaller.org/) (with **Add Ruby to PATH** checked during install)
- [PostgreSQL 17+](https://www.postgresql.org/download/windows/)
- Bundler (`gem install bundler`)

### Mobile

- [Flutter 3](https://docs.flutter.dev/get-started/install) (Dart 3)
- Android Studio (emulator) or a physical Android device

---

## Quick start

You need **two terminals**: one for the Rails API, one for the Flutter app.

### 1. Backend setup (first time only)

Open PowerShell and run **one command per line**:

```powershell
cd "C:\Users\Darshan\StudioProjects\E-Book app\backend"
bundle install
bundle exec rails db:create db:migrate
```

Set your PostgreSQL password (default user is usually `postgres`):

```powershell
$env:DATABASE_PASSWORD = "postgres"
```

> **Windows:** If `bundle` is not found, add Ruby to PATH for this session:
> ```powershell
> $env:Path = "C:\Ruby33-x64\bin;" + $env:Path
> ```
> Or add `C:\Ruby33-x64\bin` permanently via **Environment Variables → Path**.

### 2. Start the API server

```powershell
cd "C:\Users\Darshan\StudioProjects\E-Book app\backend"
$env:DATABASE_PASSWORD = "postgres"
bundle exec rails server
```

Wait until you see:

```
* Listening on http://127.0.0.1:3000
```

Verify in a **second** PowerShell window:

```powershell
Invoke-WebRequest http://localhost:3000/api/v1/health
```

Expected: HTTP `200` with `"status":"ok"`.

### 3. Run the Flutter app

In a new terminal (or Android Studio):

```powershell
cd "C:\Users\Darshan\StudioProjects\E-Book app\mobile"
flutter pub get
flutter run
```

Or open the `mobile/` folder in Android Studio and press **Run** on an Android emulator.

> **Important:** Android Studio only starts the Flutter app. The Rails server must already be running in a separate terminal.

---

## API URLs

| Client | Base URL |
|--------|----------|
| Rails (local) | `http://localhost:3000/api/v1` |
| Android emulator | `http://10.0.2.2:3000/api/v1` |
| Physical device | `http://<your-pc-lan-ip>:3000/api/v1` |

The Flutter app picks the URL in `mobile/lib/core/config/api_config.dart`:

- **Emulator:** `androidLanHost = null` → uses `10.0.2.2`
- **Real phone:** `androidLanHost = '192.168.x.x'` (your PC Wi-Fi IP from `ipconfig`)

Phone and PC must be on the **same Wi-Fi**. Restart Rails after changing Puma config so it listens on `0.0.0.0`.

---

## Demo walkthrough

With the backend running and the app open on the emulator:

1. **Library (home)** — Shows your ebook collection or an empty state with an Upload action.
2. **Upload** — Tap the **Upload** FAB → fill title (required), author, description → choose a PDF → **Upload**.
3. **Browse** — Return to the library; books appear on a bookshelf-style layout. Pull down to refresh.
4. **Read** — Tap a book card to open the in-app PDF reader (Syncfusion viewer).
5. **Search** — Tap the search icon → type a keyword (title, author, or filename). Results update after a short debounce.
6. **Download** — Use the download action on a book card; the file is saved and opened on the device.
7. **Delete** — Use delete on a card → confirm in the dialog. The ebook is soft-deleted on the server.

### Sample API calls (optional)

```powershell
# List ebooks
Invoke-WebRequest http://localhost:3000/api/v1/ebooks

# Search
Invoke-WebRequest "http://localhost:3000/api/v1/ebooks/search?q=flutter"
```

Full API docs: [docs/API.md](docs/API.md)

---

## Testing

### Backend

```powershell
cd backend
$env:DATABASE_PASSWORD = "postgres"
bundle exec rspec
bundle exec rubocop
```

### Mobile

```powershell
cd mobile
flutter analyze
flutter test
```

See [docs/TESTING.md](docs/TESTING.md) for the full testing strategy.

---

## Documentation

| Document | Description |
|----------|-------------|
| [docs/MASTER_PROJECT_SPEC.md](docs/MASTER_PROJECT_SPEC.md) | Full project specification |
| [docs/API.md](docs/API.md) | REST API reference |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System architecture |
| [docs/DATABASE.md](docs/DATABASE.md) | Database schema |
| [docs/DEVELOPMENT_PLAN.md](docs/DEVELOPMENT_PLAN.md) | Phased development plan |
| [backend/README.md](backend/README.md) | Backend-only setup |
| [mobile/README.md](mobile/README.md) | Flutter-only setup |

---

## Troubleshooting

### `bundle` or `ruby` not recognized

Ruby is not on your PATH. Run:

```powershell
$env:Path = "C:\Ruby33-x64\bin;" + $env:Path
```

Then retry. Add `C:\Ruby33-x64\bin` to your user **Path** permanently to fix this for all terminals.

### PowerShell “Unexpected token” when pasting commands

Run **one command per line**, or separate commands with semicolons:

```powershell
cd "...\backend"; $env:DATABASE_PASSWORD = "postgres"; bundle exec rails server
```

### `ridk enable` fails (script execution policy)

You do not need `ridk` to run the server. If required for native gems, use:

```powershell
C:\Ruby33-x64\bin\ridk.cmd enable
```

### App cannot connect from emulator

- Confirm Rails is running (`Listening on http://127.0.0.1:3000` or `0.0.0.0:3000`).
- Emulator must use `10.0.2.2`, not `localhost` — set `androidLanHost = null` in `api_config.dart`.

### App cannot connect from physical phone

The request URL `http://<your-pc-ip>:3000/...` must use your active adapter IP from `ipconfig`, but **Windows Firewall** often blocks inbound port 3000.

**Option A — Wi-Fi (recommended):**

1. Set `androidMode = AndroidConnectionMode.physicalDevice` and `pcLanIp` in `mobile/lib/core/config/api_config.dart`.
2. Stop all old Rails servers, start one fresh:
   ```powershell
   bundle exec rails server
   ```
3. **Allow port 3000 in firewall** — run PowerShell **as Administrator**:
   ```powershell
   cd scripts
   .\allow-rails-port-3000.ps1
   ```
4. Test on phone browser: `http://10.162.10.243:3000/api/v1/health` (use your `ipconfig` IPv4)
5. Full restart the Flutter app.

**Option B — USB (no firewall change):**

1. Phone connected via USB with USB debugging on.
2. Run: `adb reverse tcp:3000 tcp:3000`
3. Set `androidMode = AndroidConnectionMode.usbAdbReverse` in `api_config.dart`
4. Restart the Flutter app.

- Phone and PC must be on the **same Wi-Fi** for Option A.
- Only **one** Rails server should run (check with `netstat -ano | findstr :3000`).

### “A server is already running”

Stop the existing server with `Ctrl+C` in its terminal, or delete `backend/tmp/pids/server.pid` and start again.

### VIPS warnings on Rails boot

Harmless on Windows when optional image modules are missing. The API still works.

### Database connection errors

- Ensure PostgreSQL service is running.
- Confirm `DATABASE_PASSWORD` matches your `postgres` user password.
- Run `bundle exec rails db:create db:migrate` if databases are missing.

---

## License

Educational / assignment project — Sagar Fab International Company.
