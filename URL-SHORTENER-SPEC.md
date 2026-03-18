# URL Shortener — Workshop Demo Project Specification

> **Purpose:** This is the project all engineers build during the workshop using Claude Code. Everyone uses the same Laravel + SQLite boilerplate. The differences in CLAUDE.md, prompting, and approach will produce different implementations — that's the point.

---

## Overview

A URL shortening service with click tracking and analytics. Create short links, redirect visitors, track clicks, view stats.

---

## Data Model

### Link

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | UUID | Auto | Primary key |
| `url` | string (2048) | Yes | Original URL to redirect to |
| `slug` | string (20) | Yes | Short code (e.g., `abc123`). Unique. |
| `title` | string (255) | No | Human-readable label |
| `expires_at` | timestamp | No | Optional expiry date |
| `is_active` | boolean | Yes | Default: true |
| `created_at` | timestamp | Auto | |
| `updated_at` | timestamp | Auto | |

### Click

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | UUID | Auto | Primary key |
| `link_id` | UUID (FK) | Yes | The link that was clicked |
| `ip_address` | string | No | Visitor IP (anonymized) |
| `user_agent` | string | No | Browser user agent |
| `referer` | string | No | HTTP referer header |
| `country` | string (2) | No | Country code (from IP, if implemented) |
| `clicked_at` | timestamp | Yes | When the click happened |

---

## API Endpoints

### POST /api/links
Create a new short link.

**Request body:**
```json
{
  "url": "https://claude.com/product/claude-code",
  "slug": "claude-code",
  "title": "Claude Code Product Page",
  "expires_at": "2026-04-01T00:00:00Z"
}
```

- `slug` is optional — auto-generate a random 6-char slug if not provided
- `url` required, must be a valid URL
- Validate slug uniqueness

**Response:** `201 Created` with the created link including the full short URL.

### GET /api/links
List all links with click counts.

**Query parameters (all optional):**
- `search` — filter by title or URL
- `sort` — `newest` (default), `oldest`, `most_clicks`
- `per_page` — pagination (default 25)

**Response:** Paginated list of links with `clicks_count` included.

### GET /api/links/{id}
Get a single link with full details.

### GET /api/links/{id}/stats
Click analytics for a specific link.

**Response:**
```json
{
  "link": { "id": "...", "slug": "claude-code", "url": "...", "title": "..." },
  "total_clicks": 142,
  "clicks_by_day": [
    { "date": "2026-03-20", "count": 42 },
    { "date": "2026-03-19", "count": 38 }
  ],
  "top_referers": [
    { "referer": "https://claude.com", "count": 65 },
    { "referer": "direct", "count": 45 }
  ],
  "top_countries": [
    { "country": "HU", "count": 80 },
    { "country": "US", "count": 35 }
  ]
}
```

### DELETE /api/links/{id}
Soft-delete or deactivate a link.

### GET /{slug}
**The redirect endpoint.** This is the public-facing URL.

- Look up the slug
- If found and active and not expired: redirect (302) to the original URL
- Track the click asynchronously (queue job or fire-and-forget)
- If not found or expired: return 404 page

---

## Dashboard (Livewire)

A simple dashboard accessible at `/dashboard`:

- **Link list:** Table of all links with slug, title, clicks count, created date, status
- **Create link:** Form to create a new short link
- **Link detail:** Click the link to see analytics (chart of clicks over time, top referrers)
- **Search & filter:** Find links by title or URL

Keep it simple — Livewire + Tailwind. The focus is on learning Claude Code, not building a polished UI.

---

## What's Intentionally Left Open

These decisions are yours — your CLAUDE.md and prompting will shape them:

- **Architecture:** Direct Eloquent? Repository pattern? Action classes? Service layer?
- **Slug generation:** Random chars? Base62? Hashids? Nano ID?
- **Click tracking:** Synchronous? Queued job? Event + listener?
- **Validation:** Form requests? Inline? Custom rules?
- **Error handling:** How detailed? What format?
- **Testing approach:** Unit? Feature? Both? What coverage?
- **Dashboard design:** Minimal table? Cards? Charts?

---

## Bonus Features (For Fast Movers)

Pick one or more if you finish early:

- **QR code generation** — generate QR code for each short link
- **Password protection** — require a password to access certain links
- **Link groups/tags** — organize links by category
- **Bulk import** — CSV upload to create many links at once
- **Custom 404 page** — branded "link not found" page
- **API key auth** — protect the API endpoints
- **Rate limiting** — prevent abuse of the redirect endpoint
- **Link preview** — show a preview page before redirecting ("You are about to visit...")

---

## Boilerplate Provided

You'll clone a pre-configured Laravel project with:

- Laravel 12 + PHP 8.4 + SQLite
- `composer setup` — one command to get running
- `composer dev` — concurrent dev server + queue + vite
- Pre-commit hooks (Pint + PHPStan + Pest)
- CLAUDE.md with project conventions
- One example endpoint + model + migration as reference
- Tailwind CSS + Livewire ready

**You do NOT need to set up the project from scratch.** Clone, run `composer setup`, start building with Claude Code.
