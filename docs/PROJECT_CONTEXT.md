# PROJECT_CONTEXT.md

# Digital Ebook Library Application

## Project Overview

This project is being developed as a Full Stack Developer assignment.

The goal is not only to build a working application but to demonstrate professional software engineering practices, clean architecture, product thinking, testing, documentation, and maintainable code.

The application should feel like a production-ready product rather than a simple CRUD application.

The project consists of:

- Ruby on Rails API Backend
- Flutter Mobile Application
- PostgreSQL Database
- Active Storage for file uploads
- REST API communication
- Professional documentation
- Automated testing

---

# Primary Objective

Build a Digital Ebook Library where users can:

- Upload PDF ebooks
- View uploaded ebooks
- Search ebooks
- Read ebooks
- Download ebooks
- Delete ebooks

The application should be simple, modern, stable, and maintainable.

---

# Technology Stack

## Backend

- Ruby 3.3+
- Rails 8 (API Only)
- PostgreSQL
- Active Storage
- RSpec
- FactoryBot
- Faker
- Rubocop

## Frontend

- Flutter 3.35+
- Dart 3+
- Riverpod
- Dio
- Go Router
- Freezed
- Json Serializable
- Material 3

---

# Project Structure

ebook-library/

backend/
Rails API

mobile/
Flutter Application

docs/
Project Documentation

README.md

---

# Development Philosophy

Write production-quality software.

Do NOT write quick demo code.

Every feature must be:

- Modular
- Reusable
- Testable
- Maintainable
- Easy to understand

Always prioritize code quality over speed.

---

# Coding Standards

Follow:

- SOLID Principles
- DRY
- KISS
- Clean Architecture
- RESTful API Design
- Repository Pattern
- Service Object Pattern (Rails)
- Feature-first structure (Flutter)

Never duplicate code.

Always explain architectural decisions.

---

# Backend Architecture

Follow Rails best practices.

Suggested structure:

app/

controllers/
models/
services/
serializers/
policies/
validators/

spec/

requests/
models/
services/

The API must always return JSON.

Use proper HTTP status codes.

Never return HTML responses.

---

# Flutter Architecture

Use Clean Architecture.

Suggested layers:

presentation/

screens/
widgets/
providers/

domain/

entities/
repositories/

data/

models/
datasources/
repositories/

core/

network/
utils/
constants/

Keep business logic out of widgets.

---

# State Management

Use Riverpod.

Avoid unnecessary StatefulWidgets.

Business logic belongs inside providers or repositories.

---

# API Design

Every endpoint should:

Return JSON

Handle errors consistently

Return meaningful messages

Validate user input

Use proper HTTP status codes

Example:

200 OK

201 Created

400 Bad Request

404 Not Found

422 Validation Error

500 Internal Server Error

---

# File Upload Rules

Supported:

PDF

Future support:

EPUB

Validation:

Maximum size: 100 MB

Reject unsupported file types.

Store files using Active Storage.

---

# Ebook Metadata

Every ebook contains:

Title

Author

Uploaded File

File Size

Content Type

Upload Date

Created At

Updated At

Cover Image (optional)

---

# Required Features

1. Upload Ebook

2. List Ebooks

3. Search Ebooks

4. Read PDF

5. Download PDF

6. Delete Ebook

---

# Nice-to-Have Features

Bookshelf UI

Book Cover Preview

Recently Read

Remember Last Page

Sorting

Filtering

Responsive UI

Animations

Seed Data

Docker

---

# UI Requirements

The UI should resemble a modern ebook application.

Primary inspiration:

Classic Apple Books bookshelf.

Requirements:

Simple

Clean

Minimal

Responsive

Smooth animations

Material 3

Proper spacing

Readable typography

---

# Loading States

Every API request must show loading.

Do not leave blank screens.

Use:

Loading indicators

Skeleton loaders where appropriate

---

# Empty States

Examples:

No Books

No Search Results

No Internet

Upload Failed

Each empty state should guide the user.

---

# Error Handling

Never crash.

Show friendly messages.

Log errors.

Handle:

Network errors

Validation errors

Server errors

Timeouts

Unexpected exceptions

---

# Validation Rules

Title required

PDF required

Maximum file size

Valid MIME type

Author optional

Reject invalid requests.

---

# Search Requirements

Search by:

Title

Author

Filename

Bonus:

Debounce

Sorting

Filtering

Case-insensitive search

---

# Reading Requirements

Open PDF inside app.

Support:

Zoom

Page navigation

Smooth scrolling

Future:

Remember last page

---

# Delete Requirements

Ask for confirmation.

Delete from backend.

Refresh UI automatically.

Show success message.

Handle failures.

---

# Download Requirements

Download file locally.

Show progress.

Show success.

Handle failure.

---

# Security

Validate every request.

Sanitize inputs.

Never trust client data.

Avoid SQL injection.

Avoid mass assignment.

Validate uploads.

---

# Performance

Keep APIs fast.

Avoid unnecessary database queries.

Use eager loading when required.

Avoid duplicated API calls.

---

# Database

Use PostgreSQL.

Prefer normalized schema.

Create indexes where needed.

Use Active Storage.

---

# Testing

Backend:

RSpec

Test:

Models

Requests

Services

Validations

Frontend:

Widget Tests

Repository Tests

Provider Tests

Manual Testing Checklist

---

# Documentation

Every important class should be documented.

README must include:

Setup

Installation

Running

Testing

API Overview

Architecture

Known Limitations

AI Usage

---

# Git Workflow

Use feature branches.

Example:

feature/upload

feature/search

feature/download

feature/delete

Merge into develop.

Final merge into main.

---

# Development Order

Build features in this order:

1. Backend Setup

2. Database

3. Ebook Model

4. Upload API

5. List API

6. Search API

7. Download API

8. Delete API

9. Flutter Setup

10. API Integration

11. Library Screen

12. Upload Screen

13. PDF Reader

14. Search Screen

15. Download

16. Delete

17. Testing

18. Documentation

---

# AI Development Rules

When generating code:

Think like a Senior Software Engineer.

Never generate unnecessary files.

Always explain design decisions.

Generate complete implementations.

Follow best practices.

Write maintainable code.

Avoid shortcuts.

Generate tests whenever possible.

Keep code readable.

Do not over-engineer.

Do not skip validation.

Do not hardcode values.

Prefer configuration over constants.

If requirements are unclear, explain assumptions before generating code.

Never continue to the next feature unless the current feature is complete and tested.

---

# Definition of Done

A feature is complete only if:

✅ Business logic implemented

✅ UI completed

✅ API completed

✅ Validation added

✅ Error handling implemented

✅ Tests written

✅ Code formatted

✅ Documentation updated

No feature is considered complete until all items above are satisfied.

---

# Final Goal

The final application should demonstrate:

- Professional architecture
- Production-quality code
- Excellent user experience
- Proper testing
- Complete documentation
- Maintainable codebase
- Strong product thinking

This project should represent the work of a Senior Full Stack Developer and be suitable for evaluation in a professional technical assignment.