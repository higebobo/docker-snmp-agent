MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := up

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

APP_PORT=161
ADMIN="Administrator <root@localhost>"

# .env
ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

export APP_PORT
export ADMIN
export CONTAINER=snmp-agent-container

up: ## Docker process up
	@docker-compose up -d --build

down: ## Docker process down
	@docker-compose down

restart: ## Docker process restart
	@docker-compose restart

down-all: ## Docker process down all
	@docker-compose down --rmi all --volumes

clean: down-all ## Docker clean

ps: ## Docker process
	@docker-compose ps

log: ## Docker log
	@docker-compose logs

shell: ## Shell
	@docker exec -it ${CONTAINER} /bin/bash

version: ## Show version
	@docker exec -it ${CONTAINER} 'snmpwalk' '-V'

test: ## Test
	@docker exec -it ${CONTAINER} 'snmpwalk' '-v' '2c' '-c' 'public' 'localhost' '.1'

walk: ## Snmpwalk
	@docker exec -it ${CONTAINER} 'snmpwalk' '-v' '2c' '-c' 'public' 'localhost' '.1.3.6.1.2.1.25.2.3.1.5.1'

walk-system: ## Snmpwalk system
	@docker exec -it ${CONTAINER} 'snmpwalk' '-v' '2c' '-c' 'public' 'localhost' 'system'

get-os: ## Snmpget os
	@docker exec -it ${CONTAINER} 'snmpget' '-v' '2c' '-c' 'public' 'localhost' '1.3.6.1.2.1.1.1.0'

get-admin: ## Snmpget admin
	@docker exec -it ${CONTAINER} 'snmpget' '-v' '2c' '-c' 'public' 'localhost' '.1.3.6.1.2.1.1.4.0'

get-system: ## Snmpget system
	@docker exec -it ${CONTAINER} 'snmpget' '-v' '2c' '-c' 'public' 'localhost' '.1.3.6.1.2.1.1.5.0'

translate: ## Snmptranslate ipAdEntAddr
	@docker exec -it ${CONTAINER} 'snmptranslate' '.1.3.6.1.2.1.4.20.1.1' '-Of'

translate-tree: ## Snmptranslate tree
	@docker exec -it ${CONTAINER} 'snmptranslate' '-Tp'

trap: ## Snmptrap
	@docker exec -it ${CONTAINER} 'snmptrap' '-IR' '-v' '2c' '-c' 'public' '${SNMPTRAPS_HOST}' "''" 'netSnmp.99999' 'netSnmp.99999.1' 's' '"Hello, Trap"'

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[33m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
