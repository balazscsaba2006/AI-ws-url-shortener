# URL Shortener — AI Workshop Boilerplate

Pre-configured Laravel project for the **AI Workshop: Deep Dive into Claude Code**. Clone it, run one command, then build the entire URL shortener using Claude Code.

Everyone starts from the same boilerplate. The differences in CLAUDE.md, prompting approach, and architecture decisions will produce different implementations — that's the point.

## What You'll Build

A URL shortening service with click tracking and analytics: create short links, redirect visitors, track clicks, view stats on a Livewire dashboard.

See [`URL-SHORTENER-SPEC.md`](URL-SHORTENER-SPEC.md) for the full specification (data model, API endpoints, dashboard, bonus features).

## Tech Stack

- PHP 8.4+ / Laravel 13 / SQLite
- Livewire 4 + Tailwind CSS 4
- Pest (tests) / Pint (linter) / PHPStan (static analysis)
- Bun (frontend package manager)

## Setup

### Option A: Local (PHP + Bun installed)

```bash
git clone git@github.com:balazscsaba2006/AI-ws-url-shortener.git
cd AI-ws-url-shortener
composer setup     # copies .env, generates key, migrates, installs frontend deps
composer dev       # starts dev server + queue + vite concurrently
```

### Option B: Docker (nothing else needed)

```bash
git clone git@github.com:balazscsaba2006/AI-ws-url-shortener.git
cd AI-ws-url-shortener
make up            # builds & starts at http://localhost:8000
```

## Pre-commit Hooks

The project uses [pre-commit](https://pre-commit.com/) to run Pint, PHPStan, and Pest before each commit.

```bash
# Install pre-commit (once)
brew install pre-commit    # macOS
pip install pre-commit     # or via pip

# Activate hooks in this repo
pre-commit install
```

After this, every `git commit` will automatically lint, analyse, and test your code.

## Development Commands

```bash
composer dev       # start everything
composer test      # run Pest test suite
composer lint      # run Pint
composer analyse   # run PHPStan (level 6)
composer check     # lint + analyse + test (quality gate)
```

Docker equivalents: `make test`, `make check`, `make shell`.

## What's Included

- One example endpoint + model + migration as reference (`HealthCheckController`)
- Pre-commit hooks (Pint + PHPStan + Pest)
- `CLAUDE.md` with project conventions for Claude Code
- Docker setup with Dockerfile + docker-compose

## What's Intentionally NOT Included

You build everything else with Claude Code during the workshop:
- Models, migrations, controllers, routes
- API endpoints, redirect logic, click tracking
- Livewire dashboard
- Tests
