.PHONY: help build start stop restart logs clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the Docker image
	docker-compose build

start: ## Start the server
	docker-compose up -d
	@echo "Server starting... Use 'make logs' to view logs"

stop: ## Stop the server
	docker-compose down

restart: ## Restart the server
	docker-compose restart

logs: ## View server logs
	docker-compose logs -f minecraft-server

shell: ## Access server console
	docker-compose exec minecraft-server bash

backup: ## Create a backup of server data
	@mkdir -p backups
	@tar -czf backups/backup-$(shell date +%Y%m%d-%H%M%S).tar.gz server-data/
	@echo "Backup created in backups/"

clean: ## Remove all containers and volumes (WARNING: Deletes world data)
	docker-compose down -v
	@echo "All server data has been removed!"

rebuild: ## Rebuild and start the server
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d

status: ## Check server status
	docker-compose ps
