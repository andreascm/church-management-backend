.PHONY: help start stop restart logs clean reset dev prod

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

start: ## Start development environment
	./start.sh

stop: ## Stop development environment
	./stop.sh

restart: stop start ## Restart development environment

logs: ## View logs
	docker compose -f docker-compose.yml logs -f

clean: ## Clean volumes and containers
	docker compose -f docker-compose.yml down -v

reset: ## Reset everything (dangerous!)
	./reset.sh

dev: ## Start app in development mode
	npm run start:dev

install: ## Install dependencies
	npm install

# migrate: ## Run database migrations
#	npx prisma migrate dev

# studio: ## Open Prisma Studio
#	npx prisma studio