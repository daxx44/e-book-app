# Database Design

## Database

PostgreSQL

## Main Table

### ebooks

| Column | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| id | bigint | Yes | — | Primary key |
| title | string | Yes | — | Ebook title |
| author | string | No | `NULL` | Author name |
| description | text | No | `NULL` | Short description |
| status | integer | Yes | `0` (active) | Lifecycle: `active` or `deleted` |
| created_at | datetime | Yes | — | Record creation time |
| updated_at | datetime | Yes | — | Last update time |

PDF files are **not** stored in this table. Binary files use Active Storage.

File metadata (`filename`, `byte_size`, `content_type`) is read from `active_storage_blobs` at serializer/API time.

## Active Storage Tables

- `active_storage_blobs` — file key, filename, content_type, byte_size, service_name
- `active_storage_attachments` — polymorphic link between `Ebook` and blob (`name: file`)
- `active_storage_variant_records` — image variants (reserved for future cover thumbnails)

## Relationships

```
Ebook
   │
   └── has_one_attached :file
```

## Delete Strategy

Soft delete via `status` enum (`active` → `deleted`). Phase 3 `DeleteEbookService` will mark records deleted; blobs remain until explicit purge policy is added.

## Validations

- Title required (max 255 characters)
- Author optional (max 255 characters)
- Description optional (max 5000 characters)
- Status required (enum: active, deleted)
- PDF required (`has_one_attached :file`)
- PDF content type: `application/pdf` only
- Maximum file size: 100 MB
- File must not be empty

## Scopes

- `active` — non-deleted library entries
- `recent` — newest first (`created_at DESC`)
- `alphabetical` — `title ASC`
- `search_by(query)` — active ebooks only; ILIKE on title, author, blob filename

## Indexes

| Index | Column(s) | Purpose |
|-------|-----------|---------|
| `index_ebooks_on_title` | title | Sort/filter by title |
| `index_ebooks_on_author` | author | Author search |
| `index_ebooks_on_created_at` | created_at | Recent ordering |
| `index_ebooks_on_status` | status | Fast active-only queries |

## Notes

- Filename search uses `active_storage_blobs` JOIN (no denormalized filename column)
- Integer enum for `status` is compact and index-friendly vs string column
