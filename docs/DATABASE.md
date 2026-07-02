# Database Design

## Database

PostgreSQL

## Main Table

### ebooks

| Column | Type |
|---------|------|
| id | bigint |
| title | string |
| author | string |
| created_at | datetime |
| updated_at | datetime |

The PDF file is stored using Active Storage.

## Active Storage Tables

- active_storage_blobs
- active_storage_attachments

## Relationships

```
Ebook
   │
   └── has_one_attached :file
```

## Validations

- Title Required
- PDF Required
- Maximum File Size 100MB

## Indexes

- title
- author