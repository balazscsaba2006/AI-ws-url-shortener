.PHONY: up down build logs shell test lint analyse check fresh

up: ## Start the application
	docker compose up -d
	@echo ""
	@echo "  App running at http://localhost:$${APP_PORT:-8000}"
	@echo "  Vite at http://localhost:$${VITE_PORT:-5174}"
	@echo ""

down: ## Stop the application
	docker compose down

build: ## Rebuild the Docker image
	docker compose build

logs: ## Tail application logs
	docker compose logs -f

shell: ## Open a shell in the container
	docker compose exec app bash

test: ## Run tests
	docker compose exec app vendor/bin/pest

lint: ## Run Pint
	docker compose exec app vendor/bin/pint

analyse: ## Run PHPStan
	docker compose exec app vendor/bin/phpstan analyse

check: lint analyse test ## Run lint + analyse + test

fresh: down ## Rebuild from scratch
	docker compose build --no-cache
	docker compose up -d

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
