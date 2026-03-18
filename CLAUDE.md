# CLAUDE.md — URL Shortener Workshop

## Project Overview
A URL shortening service with click tracking and analytics, built with Laravel.
See `URL-SHORTENER-SPEC.md` for the full specification.

## Tech Stack
- **Language**: PHP 8.4+
- **Framework**: Laravel 13
- **Database**: SQLite (`database/database.sqlite`)
- **Frontend**: Livewire 4 + Tailwind CSS 4
- **Package manager**: bun (not npm)
- **Test runner**: Pest
- **Linter**: Pint (Laravel preset)
- **Static analysis**: PHPStan (level 6)

## Development Commands

### Option A: Local (PHP + bun installed)
```bash
composer setup          # First-time setup (env, key, migrate, bun install)
composer dev            # Start dev server + queue + vite concurrently
composer test           # Run Pest test suite
composer lint           # Run Pint
composer analyse        # Run PHPStan
composer check          # Lint + analyse + test (quality gate)
```

### Option B: Docker (nothing else needed)
```bash
make up                 # Build & start (http://localhost:8000)
make down               # Stop
make test               # Run tests in container
make check              # Lint + analyse + test in container
make shell              # Open a shell in the container
```

## Architecture
```
app/
  Http/Controllers/     # Thin controllers — validate, delegate, respond
  Models/               # Eloquent models with relationships and scopes
  Livewire/             # Livewire components for dashboard pages
routes/
  api.php               # JSON API endpoints
  web.php               # Web routes (dashboard, redirects)
database/migrations/    # Chronological migrations
tests/Feature/          # Feature tests (HTTP tests, Livewire tests)
```

## Conventions
- **Models**: Use UUIDs as primary keys (`HasUuids` trait)
- **Controllers**: One controller per resource, standard REST methods
- **Validation**: Use Form Request classes for non-trivial validation
- **API responses**: Return JSON: `{ "data": ... }` for success, standard Laravel validation errors for failures
- **Naming**: Follow Laravel conventions — `snake_case` DB columns, `camelCase` variables, `PascalCase` classes
- **Tests**: Every endpoint needs at least one happy-path and one error-path test

## Important Patterns
- The redirect endpoint (`GET /{slug}`) must be registered LAST in `web.php` to avoid catching other routes
- Click tracking should use a queued job to keep redirects fast
- Use Eloquent relationships (`Link hasMany Clicks`) with `withCount` for click stats
- See `HealthCheckController` for an example of the JSON response pattern

## Do NOT
- Add authentication or user management — this is a single-user dev project
- Use any external API services
- Change the database driver from SQLite
- Add packages without a clear reason
- Use `npm` — always use `bun`
