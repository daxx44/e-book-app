# MASTER PROJECT SPECIFICATION

**Project Name:** Digital Ebook Library

**Version:** 1.0

**Document Type:** Software Requirements Specification (SRS) + Technical Design Document + AI Development Guide

**Prepared For:** Full Stack Developer Technical Assignment

**Technology Stack**

Backend
- Ruby 3.3+
- Ruby on Rails 8 (API Only)
- PostgreSQL
- Active Storage
- RSpec

Frontend
- Flutter 3.35+
- Dart 3+
- GetX
- Dio
- Material 3

---

# 1. Project Overview

## 1.1 Purpose

The objective of this project is to develop a modern Digital Ebook Library application that allows users to manage their ebook collection through a clean, intuitive, and production-ready application.

The application must demonstrate professional software engineering practices including clean architecture, modular development, RESTful API design, testing, documentation, and thoughtful user experience.

This project is not intended to be a simple CRUD application. Instead, it should reflect how a real-world software product is designed and implemented.

---

## 1.2 Business Goal

The application should enable users to:

- Upload PDF ebooks
- View all uploaded ebooks
- Search ebooks
- Read ebooks inside the application
- Download ebooks
- Delete ebooks
- Experience a modern and responsive interface

The focus should be on usability, maintainability, scalability, and code quality.

---

# 2. Project Objectives

The project should achieve the following objectives.

## Functional Objectives

✔ Upload ebooks

✔ Store ebook metadata

✔ Display ebook library

✔ Search ebooks

✔ Read PDF inside application

✔ Download ebook

✔ Delete ebook

✔ Handle all error scenarios

---

## Technical Objectives

Implement a clean REST API.

Use PostgreSQL.

Use Active Storage.

Use Flutter for mobile application.

Maintain modular architecture.

Write readable and maintainable code.

Write automated tests.

Document the project properly.

---

## Product Objectives

Deliver an application that feels like a complete product instead of a coding assignment.

The user should never feel confused while using the application.

Every action should provide proper feedback.

---

# 3. Scope

## Included

The following features are included in this assignment.

### Ebook Upload

Users can upload PDF ebooks.

---

### Ebook Library

Users can browse uploaded ebooks.

---

### Ebook Search

Users can search ebooks by:

- Title
- Author
- File Name

---

### Ebook Reader

Users can open and read PDFs inside the application.

---

### Ebook Download

Users can download PDF files.

---

### Ebook Delete

Users can delete uploaded ebooks after confirmation.

---

### Error Handling

Proper validation

Friendly messages

Loading indicators

Retry mechanism

---

### Testing

Backend tests

Flutter tests

Manual testing checklist

---

# 4. Out of Scope

The following features are intentionally excluded.

- User Login
- User Registration
- Authentication
- Authorization
- Multiple Users
- Cloud Storage
- Payments
- Notifications
- Social Sharing

These features may be added in future versions.

---

# 5. Target Users

This application is designed for users who want to manage a personal ebook collection.

The application assumes a single-user environment.

---

# 6. User Stories

## Story 1

As a user,

I want to upload a PDF,

so that I can keep my ebook inside the library.

---

## Story 2

As a user,

I want to browse my ebooks,

so that I can easily find one to read.

---

## Story 3

As a user,

I want to search ebooks,

so that I can quickly locate a specific book.

---

## Story 4

As a user,

I want to open a PDF,

so that I can read it without leaving the application.

---

## Story 5

As a user,

I want to download my ebook,

so that I can keep a local copy.

---

## Story 6

As a user,

I want to delete ebooks,

so that I can remove unwanted books.

---

# 7. Functional Requirements

## FR-001

Upload Ebook

Description

The application shall allow the user to upload a PDF ebook.

Acceptance Criteria

- PDF picker opens
- PDF selected
- Upload starts
- Progress shown
- Upload completes
- Success message displayed

---

## FR-002

List Ebooks

The application shall display all uploaded ebooks.

Each item should display:

- Cover (placeholder if unavailable)
- Title
- Author
- Upload Date

---

## FR-003

Search

The application shall support searching by:

- Title
- Author
- Filename

Search should be case insensitive.

---

## FR-004

Read Ebook

The application shall open the selected PDF inside the application.

Minimum requirements:

- Scroll pages
- Zoom
- Stable reader

---

## FR-005

Download Ebook

The application shall allow downloading an ebook.

Requirements

Show progress.

Show success.

Handle failure.

---

## FR-006

Delete Ebook

The application shall allow deletion after confirmation.

Requirements

Confirmation dialog

Delete request

Refresh library

Success message

---

# 8. Non-Functional Requirements

## Performance

Library should load quickly.

Search should return results immediately.

Large PDFs should not crash the application.

---

## Reliability

The application should recover gracefully from network failures.

No unexpected crashes.

---

## Maintainability

Use modular architecture.

Avoid duplicate code.

Follow SOLID principles.

---

## Scalability

Architecture should allow future additions such as:

Authentication

Categories

Bookmarks

Cloud Storage

EPUB Support

---

## Security

Validate every request.

Validate uploaded files.

Reject unsupported MIME types.

Reject oversized files.

Never trust client input.

---

# 9. Product Thinking

The application should always guide the user.

Examples

If there are no books

Show an attractive empty state.

---

If upload fails

Explain why.

Allow retry.

---

If search returns nothing

Display

"No books found."

---

If internet is unavailable

Show a friendly message.

Allow retry.

---

If loading

Display loader.

Never display a blank screen.

---

# 10. Success Criteria

The project will be considered successful if:

✓ All required features work.

✓ Backend APIs are stable.

✓ Flutter app integrates correctly.

✓ UI is clean.

✓ Error handling exists.

✓ Tests pass.

✓ Documentation is complete.

✓ Code follows professional standards.

---

# 11. Future Enhancements

The architecture should allow future support for:

- EPUB Reader
- User Accounts
- Cloud Storage
- Bookmarks
- Favorites
- Reading History
- Last Read Position
- Dark Mode
- Categories
- Offline Cache
- Sync Across Devices

These features are outside the current assignment but should be considered during architectural decisions.

---

# End of Part 1

Next Document:

Part 2 – Technical Design Document

- Overall Architecture
- Database Design
- Folder Structure
- Rails Architecture
- Flutter Architecture
- API Flow
- Design Patterns
- Dependency Flow
- Data Flow
- Error Handling Strategy

# PART 2 - TECHNICAL DESIGN DOCUMENT

---

# 12. System Architecture

## Overview

The Digital Ebook Library follows a standard Client-Server architecture.

```
+-----------------------+
|   Flutter Mobile App  |
+-----------------------+
            |
            |
      HTTP / REST API
            |
            ▼
+-----------------------+
| Ruby on Rails API     |
+-----------------------+
            |
            |
      Active Record
            |
            ▼
+-----------------------+
| PostgreSQL Database   |
+-----------------------+

            |
            |
 Active Storage
            |
            ▼
 Uploaded PDF Files
```

The mobile application never communicates directly with the database.

All communication happens through REST APIs.

---

# 13. Technology Stack

## Backend

| Technology | Purpose |
|------------|----------|
| Ruby 3.3+ | Programming Language |
| Rails 8 API | REST API |
| PostgreSQL | Database |
| Active Storage | File Upload |
| RSpec | Testing |
| Rubocop | Code Quality |

---

## Frontend

| Technology | Purpose |
|------------|----------|
| Flutter | Mobile App |
| Dart | Programming Language |
| GetX | State Management |
| Dio | API Client |
| Material 3 | UI |

---

# 14. High Level Architecture

```
Flutter

│

├── Screens

├── Widgets

├── Controllers (GetX)

├── Repository

├── API Service (Dio)

│

▼

Rails REST API

│

├── Routes

├── Controllers

├── Services

├── Models

├── Active Storage

│

▼

PostgreSQL
```

---

# 15. Backend Architecture

The backend follows standard Rails architecture.

```
app/

controllers/

models/

services/

serializers/

config/

routes.rb

spec/
```

## Responsibilities

### Controller

- Receive Request
- Validate Request
- Call Service
- Return JSON

---

### Service

Contains business logic.

Examples

- Upload Ebook
- Search Ebook
- Download Ebook

---

### Model

Responsible for

- Database
- Validation
- Associations

---

### Active Storage

Stores uploaded PDF files.

---

# 16. Flutter Architecture

Flutter uses Feature-based architecture.

```
lib/

core/

constants/

network/

services/

utils/

models/

repositories/

screens/

widgets/

main.dart
```

---

## Responsibilities

### Screens

UI only.

No API calls.

---

### Repository

Communicates with Rails API.

---

### API Service

Uses Dio.

Handles

- GET
- POST
- DELETE

Common error handling.

---

### Models

Convert JSON ↔ Object.

---

### Widgets

Reusable UI components.

Example

Book Card

Loading Widget

Error Widget

Search Bar

---

# 17. Project Folder Structure

```
ebook-library/

backend/

mobile/

docs/

README.md
```

---

Backend

```
backend/

app/

config/

db/

spec/

Gemfile
```

---

Flutter

```
mobile/

lib/

assets/

android/

ios/

pubspec.yaml
```

---

# 18. Data Flow

Example

Upload Ebook

```
Flutter

↓

Select PDF

↓

POST /ebooks

↓

Rails Controller

↓

Service

↓

Model

↓

Active Storage

↓

PostgreSQL

↓

JSON Response

↓

Flutter Success Screen
```

---

Library

```
Flutter

↓

GET /ebooks

↓

Rails

↓

Database

↓

JSON

↓

Flutter Grid View
```

---

Delete

```
Flutter

↓

DELETE /ebooks/:id

↓

Rails

↓

Delete Record

↓

Delete File

↓

JSON

↓

Refresh List
```

---

# 19. Design Principles

The application should follow

## SOLID

Single Responsibility

Open Closed

Liskov

Interface Segregation

Dependency Inversion

---

## DRY

Don't Repeat Yourself.

---

## KISS

Keep It Simple.

---

## YAGNI

Don't build features not required.

---

# 20. Error Handling Strategy

Backend

Always return JSON.

Example

```
{
  "success": false,
  "message": "Validation failed"
}
```

Use proper HTTP status.

200

201

400

404

422

500

---

Flutter

Display

Loading

Success

Error

Empty State

Retry Button

---

# 21. Validation Strategy

Backend validation is mandatory.

Examples

Title required.

PDF required.

Only PDF accepted.

Maximum 100MB.

Reject invalid requests.

Frontend validation improves UX but backend remains the source of truth.

---

# 22. Logging Strategy

Rails

Log

Requests

Errors

Exceptions

Database errors

Flutter

Log

API Request

API Response

Errors

Use logging only for development.

---

# 23. File Storage

PDF files are stored using Active Storage.

Advantages

Simple

Reliable

Rails native

Future support for cloud storage.

The Ebook model stores metadata while Active Storage stores the file.

---

# 24. API Communication

All communication uses JSON.

Example

```
Flutter

↓

Dio

↓

HTTP

↓

Rails

↓

JSON

↓

Flutter
```

No direct database communication.

---

# 25. Dependency Flow

Flutter

```
Screen

↓

Controller

↓

Repository

↓

API Service

↓

Rails API
```

Rails

```
Route

↓

Controller

↓

Service

↓

Model

↓

Database
```

Dependencies always flow in one direction.

---

# 26. Performance Considerations

Keep APIs lightweight.

Avoid duplicate database queries.

Use pagination if required.

Optimize PDF loading.

Avoid rebuilding unnecessary widgets.

Keep network payload small.

---

# 27. Security Considerations

Validate every request.

Validate uploaded files.

Reject unsupported MIME types.

Reject oversized files.

Do not expose internal server errors.

Use strong parameter validation.

---

# 28. Scalability

Architecture should allow future support for

Authentication

Bookmarks

Categories

Favorites

Reading History

Cloud Storage

EPUB

Dark Mode

Offline Support

No major architectural changes should be required.

---

# 29. Definition of Ready

Before starting any feature ensure

✔ Requirements understood

✔ API identified

✔ UI identified

✔ Validation identified

✔ Test cases identified

---

# 30. Definition of Done

A feature is complete only when

✔ Backend completed

✔ API tested

✔ Flutter UI completed

✔ Error handling completed

✔ Validation completed

✔ Documentation updated

✔ Tests passed

✔ Code reviewed

No feature should be marked complete before satisfying all items.

---

# End of Part 2

Next Part

Part 3 – Backend Technical Design

Contents

- PostgreSQL Design
- Active Storage Configuration
- Rails Models
- Services
- Controllers
- Routes
- API Standards
- JSON Response Standards
- Validation Rules
- RSpec Strategy

# PART 3 – BACKEND TECHNICAL DESIGN

---

# 31. Backend Overview

The backend will be developed using **Ruby on Rails 8 API Only**.

Responsibilities:

- Provide REST APIs
- Manage ebook metadata
- Upload PDF files
- Download PDF files
- Search ebooks
- Delete ebooks
- Validate requests
- Handle errors
- Return standardized JSON responses

The backend should remain stateless and should not contain any UI logic.

---

# 32. Backend Technology Stack

| Component | Technology |
|------------|------------|
| Language | Ruby 3.3+ |
| Framework | Rails 8 API |
| Database | PostgreSQL |
| File Storage | Active Storage |
| Testing | RSpec |
| Code Style | Rubocop |
| API Format | JSON |

---

# 33. Backend Folder Structure

```
backend/

app/
│
├── controllers/
│
├── models/
│
├── services/
│
├── serializers/
│
├── validators/
│
└── jobs/

config/

db/

spec/

storage/
```

---

# 34. Database Design

## ebooks

| Column | Type | Required |
|---------|------|----------|
| id | bigint | Yes |
| title | string | Yes |
| author | string | No |
| description | text | No |
| status | integer | Yes |
| created_at | datetime | Yes |
| updated_at | datetime | Yes |

PDF files will NOT be stored inside this table.

Files are managed by Active Storage.

---

# 35. Active Storage

Each ebook has one attached PDF.

Model

```
has_one_attached :file
```

Benefits

- Native Rails support
- Secure file handling
- Easy future migration to cloud storage
- Stores metadata automatically

---

# 36. Model Responsibilities

The Ebook model should only contain:

- Associations
- Validations
- Scopes
- Enums
- Small helper methods

Avoid placing business logic inside models.

Business logic belongs in Services.

---

# 37. Suggested Model

```
Ebook

title

author

description

status

file
```

Status enum

```
active

deleted
```

---

# 38. Validation Rules

Required

- title
- file

Optional

- author
- description

File validation

- PDF only
- Maximum size 100MB

Reject

- Empty files
- Unsupported MIME types

---

# 39. Scopes

Suggested scopes

Recent

```
Newest first
```

Alphabetical

```
Order by title
```

Search

```
Title

Author
```

---

# 40. Services

Business logic should live in Service Objects.

Example

```
UploadEbookService

SearchEbookService

DeleteEbookService

DownloadEbookService
```

Responsibilities

- Validation
- Business rules
- Transactions
- Error handling

Controllers should remain thin.

---

# 41. Controllers

Responsibilities

Receive Request

↓

Validate Parameters

↓

Call Service

↓

Return JSON

Controllers should NOT contain business logic.

---

# 42. Routes

Base URL

```
/api/v1
```

Routes

```
GET

/api/v1/ebooks
```

```
POST

/api/v1/ebooks
```

```
GET

/api/v1/ebooks/:id
```

```
GET

/api/v1/ebooks/search
```

```
GET

/api/v1/ebooks/:id/download
```

```
DELETE

/api/v1/ebooks/:id
```

Future

```
PUT

PATCH
```

can be added if editing is required.

---

# 43. Request Validation

Validate every request.

Examples

Upload

- title exists
- file exists

Search

- empty keyword allowed
- trim spaces

Delete

- record exists

Download

- file exists

---

# 44. JSON Response Standard

Success

```
{
  "success": true,
  "message": "Ebook uploaded successfully",
  "data": {}
}
```

Error

```
{
  "success": false,
  "message": "Validation failed",
  "errors": []
}
```

All endpoints should follow the same format.

---

# 45. HTTP Status Codes

| Code | Meaning |
|------|---------|
|200|Success|
|201|Created|
|400|Bad Request|
|404|Not Found|
|422|Validation Failed|
|500|Internal Server Error|

---

# 46. Search Logic

Search by

- Title
- Author

Case insensitive.

Ignore leading and trailing spaces.

Future

- File Name
- Description

---

# 47. Error Handling

Handle

Validation errors

Database errors

Missing files

Record not found

Unexpected exceptions

Never expose stack traces.

Log server errors.

Return friendly messages.

---

# 48. Security

Use Strong Parameters.

Never trust client input.

Validate uploads.

Reject executable files.

Validate MIME type.

Validate file size.

Escape SQL inputs.

---

# 49. Logging

Log

- Requests
- Responses
- Exceptions
- Upload failures

Avoid logging sensitive information.

---

# 50. Performance

Keep controllers thin.

Avoid N+1 queries.

Select only required fields.

Use indexes.

Avoid duplicate queries.

---

# 51. API Versioning

All APIs should be versioned.

Example

```
/api/v1/ebooks
```

Allows future versions without breaking clients.

---

# 52. Testing Strategy

RSpec

Test

Models

Request Specs

Services

Validation

Error cases

Edge cases

---

# 53. Manual Test Cases

Upload valid PDF

Upload invalid file

Upload large file

Search existing book

Search unknown book

Download book

Delete book

Delete missing book

Network failure

Server error

---

# 54. Future Improvements

Authentication

JWT

Pagination

Sorting

Filtering

Bookmarks

Favorites

Cloud Storage

Background Jobs

Thumbnail generation

EPUB support

---

# 55. Backend Coding Standards

Controllers

- Thin
- RESTful
- No business logic

Models

- Associations
- Validation
- Scopes

Services

- One responsibility
- Reusable
- Testable

Routes

- Versioned
- REST compliant

Responses

- Consistent JSON

Testing

- Every API should have request specs

---

# 56. Backend Definition of Done

A backend feature is complete only if:

✅ Migration created

✅ Model completed

✅ Validation added

✅ Service implemented

✅ Controller implemented

✅ Routes added

✅ JSON response standardized

✅ Error handling implemented

✅ Tests written

✅ Rubocop passes

✅ API verified using Postman

---

# End of Part 3

Next Part

# PART 4 – Flutter Technical Design

Contents

- Flutter Architecture
- Folder Structure
- State Management
- Repository Pattern
- API Layer
- UI Design
- Navigation
- Theme
- PDF Reader
- Download Manager
- Error Handling
- Loading States
- Empty States
- Widget Design
- Flutter Testing Strategy

# PART 3 – BACKEND TECHNICAL DESIGN

---

# 31. Backend Overview

The backend will be developed using **Ruby on Rails 8 API Only**.

Responsibilities:

- Provide REST APIs
- Manage ebook metadata
- Upload PDF files
- Download PDF files
- Search ebooks
- Delete ebooks
- Validate requests
- Handle errors
- Return standardized JSON responses

The backend should remain stateless and should not contain any UI logic.

---

# 32. Backend Technology Stack

| Component | Technology |
|------------|------------|
| Language | Ruby 3.3+ |
| Framework | Rails 8 API |
| Database | PostgreSQL |
| File Storage | Active Storage |
| Testing | RSpec |
| Code Style | Rubocop |
| API Format | JSON |

---

# 33. Backend Folder Structure

```
backend/

app/
│
├── controllers/
│
├── models/
│
├── services/
│
├── serializers/
│
├── validators/
│
└── jobs/

config/

db/

spec/

storage/
```

---

# 34. Database Design

## ebooks

| Column | Type | Required |
|---------|------|----------|
| id | bigint | Yes |
| title | string | Yes |
| author | string | No |
| description | text | No |
| status | integer | Yes |
| created_at | datetime | Yes |
| updated_at | datetime | Yes |

PDF files will NOT be stored inside this table.

Files are managed by Active Storage.

---

# 35. Active Storage

Each ebook has one attached PDF.

Model

```
has_one_attached :file
```

Benefits

- Native Rails support
- Secure file handling
- Easy future migration to cloud storage
- Stores metadata automatically

---

# 36. Model Responsibilities

The Ebook model should only contain:

- Associations
- Validations
- Scopes
- Enums
- Small helper methods

Avoid placing business logic inside models.

Business logic belongs in Services.

---

# 37. Suggested Model

```
Ebook

title

author

description

status

file
```

Status enum

```
active

deleted
```

---

# 38. Validation Rules

Required

- title
- file

Optional

- author
- description

File validation

- PDF only
- Maximum size 100MB

Reject

- Empty files
- Unsupported MIME types

---

# 39. Scopes

Suggested scopes

Recent

```
Newest first
```

Alphabetical

```
Order by title
```

Search

```
Title

Author
```

---

# 40. Services

Business logic should live in Service Objects.

Example

```
UploadEbookService

SearchEbookService

DeleteEbookService

DownloadEbookService
```

Responsibilities

- Validation
- Business rules
- Transactions
- Error handling

Controllers should remain thin.

---

# 41. Controllers

Responsibilities

Receive Request

↓

Validate Parameters

↓

Call Service

↓

Return JSON

Controllers should NOT contain business logic.

---

# 42. Routes

Base URL

```
/api/v1
```

Routes

```
GET

/api/v1/ebooks
```

```
POST

/api/v1/ebooks
```

```
GET

/api/v1/ebooks/:id
```

```
GET

/api/v1/ebooks/search
```

```
GET

/api/v1/ebooks/:id/download
```

```
DELETE

/api/v1/ebooks/:id
```

Future

```
PUT

PATCH
```

can be added if editing is required.

---

# 43. Request Validation

Validate every request.

Examples

Upload

- title exists
- file exists

Search

- empty keyword allowed
- trim spaces

Delete

- record exists

Download

- file exists

---

# 44. JSON Response Standard

Success

```
{
  "success": true,
  "message": "Ebook uploaded successfully",
  "data": {}
}
```

Error

```
{
  "success": false,
  "message": "Validation failed",
  "errors": []
}
```

All endpoints should follow the same format.

---

# 45. HTTP Status Codes

| Code | Meaning |
|------|---------|
|200|Success|
|201|Created|
|400|Bad Request|
|404|Not Found|
|422|Validation Failed|
|500|Internal Server Error|

---

# 46. Search Logic

Search by

- Title
- Author

Case insensitive.

Ignore leading and trailing spaces.

Future

- File Name
- Description

---

# 47. Error Handling

Handle

Validation errors

Database errors

Missing files

Record not found

Unexpected exceptions

Never expose stack traces.

Log server errors.

Return friendly messages.

---

# 48. Security

Use Strong Parameters.

Never trust client input.

Validate uploads.

Reject executable files.

Validate MIME type.

Validate file size.

Escape SQL inputs.

---

# 49. Logging

Log

- Requests
- Responses
- Exceptions
- Upload failures

Avoid logging sensitive information.

---

# 50. Performance

Keep controllers thin.

Avoid N+1 queries.

Select only required fields.

Use indexes.

Avoid duplicate queries.

---

# 51. API Versioning

All APIs should be versioned.

Example

```
/api/v1/ebooks
```

Allows future versions without breaking clients.

---

# 52. Testing Strategy

RSpec

Test

Models

Request Specs

Services

Validation

Error cases

Edge cases

---

# 53. Manual Test Cases

Upload valid PDF

Upload invalid file

Upload large file

Search existing book

Search unknown book

Download book

Delete book

Delete missing book

Network failure

Server error

---

# 54. Future Improvements

Authentication

JWT

Pagination

Sorting

Filtering

Bookmarks

Favorites

Cloud Storage

Background Jobs

Thumbnail generation

EPUB support

---

# 55. Backend Coding Standards

Controllers

- Thin
- RESTful
- No business logic

Models

- Associations
- Validation
- Scopes

Services

- One responsibility
- Reusable
- Testable

Routes

- Versioned
- REST compliant

Responses

- Consistent JSON

Testing

- Every API should have request specs

---

# 56. Backend Definition of Done

A backend feature is complete only if:

✅ Migration created

✅ Model completed

✅ Validation added

✅ Service implemented

✅ Controller implemented

✅ Routes added

✅ JSON response standardized

✅ Error handling implemented

✅ Tests written

✅ Rubocop passes

✅ API verified using Postman

---

# End of Part 3

Next Part

# PART 4 – Flutter Technical Design

Contents

- Flutter Architecture
- Folder Structure
- State Management
- Repository Pattern
- API Layer
- UI Design
- Navigation
- Theme
- PDF Reader
- Download Manager
- Error Handling
- Loading States
- Empty States
- Widget Design
- Flutter Testing Strategy


# PART 4 – FLUTTER TECHNICAL DESIGN

---

# 57. Flutter Overview

The mobile application will be developed using Flutter.

The application communicates with the Ruby on Rails backend through REST APIs.

The Flutter application is responsible for:

- Displaying the ebook library
- Uploading PDF files
- Searching ebooks
- Reading PDFs
- Downloading PDFs
- Deleting ebooks
- Displaying loading, empty and error states

---

# 58. Technology Stack

| Component | Technology |
|------------|------------|
| Framework | Flutter 3.35+ |
| Language | Dart 3 |
| State Management | GetX |
| Networking | Dio |
| Local Storage | SharedPreferences |
| File Picker | file_picker |
| PDF Reader | syncfusion_flutter_pdfviewer |
| Permissions | permission_handler |
| File Storage | path_provider |
| Open File | open_filex |

---

# 59. Flutter Folder Structure

```

lib/

core/
│
├── api/
├── config/
├── constants/
├── services/
├── theme/
├── utils/

models/

repositories/

controllers/

screens/

widgets/

routes/

main.dart

```

---

# 60. Application Flow

```

App Start

↓

Load Library

↓

Display Books

↓

User Action

↓

API Request

↓

Rails API

↓

JSON Response

↓

Update UI

```

---

# 61. State Management

GetX will be used for:

- State Management
- Dependency Injection
- Navigation

Each screen should have its own controller.

Example

```

LibraryController

UploadController

ReaderController

SearchController

```

Responsibilities:

- Manage UI State
- Call Repository
- Handle Errors
- Trigger UI Updates

---

# 62. Repository Pattern

The repository layer separates UI from networking.

```

Controller

↓

Repository

↓

ApiService

↓

Rails API

```

Benefits

- Easy Testing
- Reusable Code
- Separation of Concerns

---

# 63. API Layer

Dio will be used for all HTTP requests.

Responsibilities

- GET
- POST
- DELETE
- File Upload
- File Download
- Error Handling
- Timeout Handling

No screen should call Dio directly.

---

# 64. Routing

Use GetX Navigation.

Suggested Routes

```

/

library

upload

reader

search

```

Navigation should remain centralized.

---

# 65. Screen List

## Library Screen

Shows all uploaded ebooks.

Features

- Grid View
- Search Button
- Upload Button
- Empty State

---

## Upload Screen

Features

- Pick PDF
- Enter Title
- Enter Author
- Upload Progress
- Success Message

---

## Reader Screen

Features

- PDF Viewer
- Zoom
- Scroll
- Page Navigation

---

## Search Screen

Features

- Search Field
- Live Results
- Empty Search State

---

# 66. Widget Structure

Reusable Widgets

BookCard

PrimaryButton

LoadingWidget

EmptyWidget

ErrorWidget

SearchBar

ConfirmationDialog

Widgets should remain reusable.

---

# 67. UI Guidelines

Use Material 3.

Keep UI

- Simple
- Modern
- Responsive
- Minimal

Avoid clutter.

---

# 68. Library UI

Display books in Grid View.

Each card contains

- Cover Placeholder
- Title
- Author
- Upload Date

Long titles should truncate gracefully.

---

# 69. Loading States

Every API call should display loading.

Examples

Library Loading

Upload Progress

Download Progress

Search Loading

Never display a blank screen.

---

# 70. Empty States

Library Empty

"No books available."

Search Empty

"No matching books found."

Upload Failure

"Upload failed. Please try again."

Provide clear actions.

---

# 71. Error Handling

Handle

Network Error

Timeout

Validation Error

Server Error

Unexpected Error

Display Snackbar or Dialog.

Never crash the application.

---

# 72. File Upload Flow

```

User Picks PDF

↓

Validate

↓

Select Title

↓

API Upload

↓

Server Validation

↓

Success

↓

Refresh Library

```

---

# 73. Download Flow

```

User taps Download

↓

Download API

↓

Save File

↓

Success Message

↓

Open File (Optional)

```

---

# 74. Delete Flow

```

Delete Button

↓

Confirmation Dialog

↓

Delete API

↓

Refresh Library

↓

Success Snackbar

```

---

# 75. Search Flow

```

User Types

↓

Controller

↓

Repository

↓

API

↓

Results

↓

Update Grid

```

---

# 76. Theme

Material 3

Light Theme

Consistent

- Colors
- Typography
- Buttons
- Cards
- Icons

Future

Dark Theme

---

# 77. Local Storage

SharedPreferences may be used for

- Last Search
- Theme
- Settings

Do not store ebooks locally.

---

# 78. Performance

Avoid unnecessary rebuilds.

Lazy load images.

Keep controllers lightweight.

Dispose resources properly.

---

# 79. Flutter Testing

Widget Tests

Library Screen

Upload Screen

Search Screen

Book Card

Delete Dialog

Repository Tests

API Service Tests

---

# 80. Flutter Coding Standards

Controllers

- UI State Only

Repositories

- API Calls Only

Widgets

- UI Only

Models

- JSON Parsing

Services

- Shared Logic

Keep files small and readable.

---

# 81. Flutter Definition of Done

A Flutter feature is complete only if

✅ Screen completed

✅ Controller completed

✅ Repository completed

✅ API integrated

✅ Loading state added

✅ Empty state added

✅ Error handling added

✅ UI tested

✅ No analyzer warnings

✅ Code formatted

---

# End of Part 4

Next Part

# PART 5 – AI DEVELOPMENT GUIDE

Contents

- Cursor AI Workflow
- Prompt Engineering Guidelines
- Coding Rules
- Review Checklist
- Refactoring Rules
- Debugging Workflow
- Commit Strategy
- AI Best Practices
- Development Milestones


# PART 5 – AI DEVELOPMENT GUIDE

---

# 82. Purpose

This document defines how AI tools should be used during development.

Supported AI Tools:

- Cursor AI
- ChatGPT
- Claude Code
- GitHub Copilot

AI should be treated as a senior development assistant, not as an automatic code generator.

Every generated solution must be reviewed before acceptance.

---

# 83. AI Role

The AI acts as a Senior Full Stack Engineer.

Responsibilities:

- Understand requirements
- Follow project architecture
- Generate clean code
- Suggest improvements
- Explain implementation decisions
- Write tests
- Help debug issues
- Improve documentation

The AI should never make architectural decisions that conflict with the project specification.

---

# 84. AI Development Workflow

Every feature must follow this workflow.

Step 1

Read documentation.

↓

Step 2

Understand requirements.

↓

Step 3

Explain implementation plan.

↓

Step 4

Generate implementation.

↓

Step 5

Generate tests.

↓

Step 6

Review code quality.

↓

Step 7

Wait for approval before continuing.

---

# 85. AI Coding Rules

Always follow:

- SOLID Principles
- DRY
- KISS
- Rails Best Practices
- Flutter Best Practices
- REST Standards

Never generate duplicate code.

Never ignore validation.

Never hardcode values.

Never skip testing.

Never generate unused files.

---

# 86. Backend AI Rules

Backend code must:

Use Rails conventions.

Keep controllers thin.

Move business logic into Services.

Validate all requests.

Return consistent JSON.

Use Active Storage correctly.

Generate request specs.

Avoid N+1 queries.

Use Strong Parameters.

Write readable code.

---

# 87. Flutter AI Rules

Flutter code must:

Use GetX for state management.

Separate UI from business logic.

Use Repository Pattern.

Keep widgets reusable.

Use Material 3.

Handle:

Loading

Empty

Error

Success

Avoid putting API calls directly inside Widgets.

---

# 88. Before Generating Code

Before implementing any feature the AI should:

Read PROJECT_CONTEXT.md.

Read all documentation inside docs/.

Summarize the feature.

Explain assumptions.

Identify possible edge cases.

Only then generate code.

---

# 89. Code Review Checklist

Before completing any feature verify:

✓ No duplicate code

✓ Naming is meaningful

✓ Methods are small

✓ Validation exists

✓ Error handling exists

✓ Logging added where needed

✓ Tests included

✓ Documentation updated

---

# 90. Refactoring Guidelines

Refactor whenever:

Methods become too large.

Controllers become complex.

Duplicate code appears.

Naming becomes confusing.

Business logic enters UI.

Maintain readability over cleverness.

---

# 91. Debugging Guidelines

When debugging:

1. Explain the issue.

2. Identify possible causes.

3. Suggest the safest fix.

4. Implement only after approval.

Never rewrite unrelated code.

---

# 92. Feature Implementation Order

Implement features only in this order.

1.

Backend Setup

↓

2.

Database

↓

3.

Model

↓

4.

Upload API

↓

5.

List API

↓

6.

Search API

↓

7.

Download API

↓

8.

Delete API

↓

9.

Flutter Setup

↓

10.

API Integration

↓

11.

Library Screen

↓

12.

Upload Screen

↓

13.

Reader Screen

↓

14.

Search Screen

↓

15.

Testing

↓

16.

Documentation

Never skip steps.

---

# 93. Prompting Guidelines

Each prompt should contain:

Objective

Requirements

Expected Output

Constraints

Definition of Done

Avoid vague prompts such as:

"Build the app."

Prefer:

"Implement Upload API using Active Storage with validation and RSpec tests."

---

# 94. Code Generation Standards

Generated code should:

Compile successfully.

Follow formatting standards.

Contain comments only where useful.

Avoid unnecessary complexity.

Be production ready.

---

# 95. Error Handling Standards

Always handle:

Validation Errors

Network Errors

Database Errors

Timeouts

Unexpected Exceptions

Display user-friendly messages.

Never expose internal implementation details.

---

# 96. Testing Requirements

Every feature should include:

Backend

- Model Tests
- Request Specs

Flutter

- Widget Tests
- Repository Tests

Manual

- Test Checklist

No feature is complete without testing.

---

# 97. Documentation Requirements

After completing each feature update:

README

API Documentation

Testing Guide

Development Plan

Documentation should always reflect the current implementation.

---

# 98. Git Workflow

Recommended branches

main

develop

feature/backend-upload

feature/backend-search

feature/flutter-library

feature/flutter-reader

Each feature should have a clear commit history.

Example

feat: add ebook upload API

fix: validate pdf mime type

refactor: move upload logic into service

test: add upload request specs

---

# 99. Definition of Done

A feature is complete only if:

✅ Requirements implemented

✅ Architecture followed

✅ Validation added

✅ Error handling added

✅ Tests written

✅ Documentation updated

✅ Code reviewed

✅ Formatting completed

✅ No analyzer warnings

✅ No Rubocop offenses

---

# 100. Final AI Rules

The AI must always:

Think before coding.

Follow documentation.

Keep architecture consistent.

Write maintainable code.

Prefer clarity over cleverness.

Avoid shortcuts.

Never implement unrelated features.

Ask for clarification if requirements are unclear.

Always produce code that another senior developer can easily understand and maintain.

---

# End of Part 5

Next Part

PART 6 – Deployment, Submission & Final Checklist

Contents

- Local Development Setup
- Backend Installation
- Flutter Installation
- PostgreSQL Setup
- Running the Project
- Connecting Flutter with Rails
- Environment Configuration
- Testing Commands
- Submission Checklist
- README Structure
- Demo Video Checklist
- Final Project Review

# PART 6 – LOCAL DEVELOPMENT, DEPLOYMENT & FINAL CHECKLIST

---

# 101. Local Development Environment

## Operating System

Recommended:

- Windows 11
- macOS
- Ubuntu 22+

---

## Required Software

Backend

- Ruby 3.3+
- Rails 8
- PostgreSQL 16+
- Bundler

Frontend

- Flutter 3.35+
- Android Studio
- Xcode (macOS only)

Development

- Cursor IDE
- Git
- GitHub
- Postman

---

# 102. Backend Setup

Create Rails API

```

rails new backend --api -d postgresql

```

Install Gems

```

bundle install

```

Create Database

```

rails db:create

```

Run Migration

```

rails db:migrate

```

Install Active Storage

```

rails active_storage:install

rails db:migrate

```

Run Server

```

rails server

```

Backend URL

```

http://localhost:3000

```

---

# 103. Flutter Setup

Create Project

```

flutter create mobile

```

Install Packages

```

flutter pub get

```

Run

```

flutter run

```

---

# 104. Flutter Packages

Recommended packages

```

get

dio

file_picker

syncfusion_flutter_pdfviewer

permission_handler

path_provider

shared_preferences

intl

fluttertoast

```

Development

```

build_runner

json_serializable

flutter_lints

```

---

# 105. Connecting Flutter with Rails

Android Emulator

```

http://10.0.2.2:3000

```

iOS Simulator

```

http://localhost:3000

```

Physical Device

```

http://YOUR_LOCAL_IP:3000

```

Example

```

http://192.168.1.20:3000

```

---

# 106. Environment Configuration

Backend

Use environment variables for

Database

Storage

Secrets

Flutter

Create

```

lib/core/config/api_config.dart

```

Example

```

class ApiConfig {

static const baseUrl = "...";

}

```

Never hardcode URLs inside widgets.

---

# 107. API Testing

Test every endpoint before connecting Flutter.

Use

Postman

or

Thunder Client

Verify

✓ Upload

✓ List

✓ Search

✓ Download

✓ Delete

---

# 108. Development Order

Backend

✓ Project Setup

↓

✓ Database

↓

✓ Upload API

↓

✓ List API

↓

✓ Search API

↓

✓ Download API

↓

✓ Delete API

↓

Testing

↓

Flutter

↓

Integration

↓

Documentation

---

# 109. Manual Testing Checklist

Backend

□ Upload PDF

□ Invalid File

□ Large File

□ Search

□ Download

□ Delete

Flutter

□ Library Screen

□ Upload

□ Search

□ Reader

□ Download

□ Delete

□ Loading

□ Empty State

□ Error State

---

# 110. README Structure

README should contain

Project Overview

Technology Stack

Setup Instructions

Backend Setup

Flutter Setup

Running Project

API Documentation

Testing

Screenshots

AI Usage

Known Limitations

Future Improvements

---

# 111. Demo Video Checklist

Record

✓ Upload

✓ Library

✓ Search

✓ Reader

✓ Download

✓ Delete

✓ Empty State

Explain

Architecture

Technology

Testing

AI Usage

---

# 112. AI Usage Report

Include

AI Tools Used

Examples

Cursor

ChatGPT

Claude

Explain

Where AI helped

Where code was modified manually

What was rejected

How debugging was done

Keep it honest.

---

# 113. Known Limitations

Document any unfinished work.

Example

No Authentication

No EPUB Support

No Offline Storage

No Cloud Storage

This demonstrates awareness rather than weakness.

---

# 114. Future Enhancements

Authentication

Bookmarks

Favorites

Dark Theme

EPUB Reader

Cloud Storage

Book Categories

Reading History

Offline Support

Pagination

Sorting

Filtering

---

# 115. Final Submission Checklist

Backend

□ Rails Project

□ PostgreSQL

□ Active Storage

□ APIs Working

□ Tests Passing

Flutter

□ App Builds Successfully

□ APIs Connected

□ UI Complete

□ Error Handling

□ Loading States

□ Empty States

Documentation

□ README

□ API Documentation

□ Architecture

□ Testing Guide

□ AI Usage Report

Media

□ Screenshots

□ Demo Video

Repository

□ GitHub Repository

□ Clean Commit History

□ No Sensitive Files

---

# 116. Project Completion Criteria

The project is complete only when:

✓ All required features are implemented.

✓ Backend APIs are functional.

✓ Flutter application works correctly.

✓ Database is stable.

✓ Active Storage works correctly.

✓ Tests pass successfully.

✓ Documentation is complete.

✓ README is updated.

✓ Demo video is prepared.

✓ GitHub repository is clean.

---

# 117. Final Notes

Focus on quality over quantity.

Write clean and maintainable code.

Follow the documented architecture.

Test every feature before moving to the next one.

Review AI-generated code carefully before accepting it.

Deliver a solution that demonstrates professional software engineering practices and thoughtful product development.

---

# END OF MASTER PROJECT SPECIFICATION