# Architecture

## Overview

The Digital Ebook Library is a client-server application consisting of:

- Flutter Mobile Application
- Ruby on Rails REST API
- PostgreSQL Database
- Active Storage for ebook files

```
Flutter App
      │
      │ REST API (JSON)
      ▼
Ruby on Rails API
      │
      ├── PostgreSQL
      └── Active Storage
```

## Backend Responsibilities

- Ebook CRUD APIs
- File Upload
- Search
- Download
- Validation
- Error Handling

## Frontend Responsibilities

- Display Ebook Library
- Upload Ebook
- Search
- Read PDF
- Download
- Delete

## Folder Structure

### Backend

```
app/
controllers/
models/
services/
serializers/
```

### Flutter

```
lib/
core/
models/
repositories/
screens/
widgets/
services/
utils/
```

## Design Principles

- REST API
- Clean Code
- SOLID Principles
- Repository Pattern
- Separation of Concerns
- Reusable Components

## Error Handling

All API errors use a single JSON envelope. See `API.md` for full schemas.

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Please correct the errors below.",
    "details": [
      { "field": "title", "code": "blank", "message": "Title can't be blank" }
    ]
  }
}
```

- `error.code` — stable identifier for client logic (`NOT_FOUND`, `VALIDATION_FAILED`, etc.)
- `error.message` — user-facing summary
- `error.details` — optional field-level errors for forms

Handled cases:

- Validation Errors → 422 + `VALIDATION_FAILED`
- Not Found → 404 + `NOT_FOUND`
- Network Errors → handled on Flutter client
- Server Errors → 500 + `INTERNAL_SERVER_ERROR`

## Future Improvements

- Authentication
- EPUB Support
- Cloud Storage
- Last Read Position
- Book Categories