##----------------------------------------------------------------------------------------------------------------------
##--------------------------------------------------- Stack Makefile ---------------------------------------------------
##----------------------------------------------------------------------------------------------------------------------
DC=docker compose

.DEFAULT_GOAL := help
.PHONY: help
help : Makefile # Print commands help.
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

export
HOST_UID=$(shell id -u)
HOST_GID=$(shell id -g)

##
## Docker
##----------------------------------------------------------------------------------------------------------------------
.PHONY: build config init logs ps up

build: ## Build docker images
	@echo "Build docker images"
	$(DC) build --build-arg UID=$(HOST_UID) --build-arg GID=$(HOST_GID)

config: ## Display compose config
	$(DC) config

logs: ## Display container logs (exp: make logs traefik)
	$(DC) logs -f -n 20 $(filter-out $@,$(MAKECMDGOALS))

ps: ## Containers list
	$(DC) ps -a

up: init build ## Build and run containers
	@echo "Starting up containers"
	$(DC) up -d --remove-orphans --force-recreate

##
## Shell
##----------------------------------------------------------------------------------------------------------------------
.PHONY: shell

shell: ## Connect to traefik container
	$(DC) exec minio sh
