### HELPERS ###
BOLD := $(shell tput bold)
SGR0 := $(shell tput sgr0)

define MSG
printf '${BOLD}=> $(subst ",,$(strip $(1)))$(SGR0)\n'
endef


### DEVELOPMENT ###

local.dirs:
	@mkdir -p ./log && mkdir -p ./tmp

local.up: local.dirs
	@$(call MSG, "Running local development environment")
	docker-compose -f docker-compose.yml up --build --detach

local.setup: local.dirs local.database

local.database: local.database.development local.database.test

local.database.development:
	@$(call MSG, "Setting up [development] database")
	docker-compose -f docker-compose.yml exec \
	--env DATABASE_URL=postgresql://postgres:postgres@db/wellio-fit-development app \
	bundle exec rake db:drop db:create db:migrate

local.database.test:
	@$(call MSG, "Setting up [test] database")
	docker-compose -f docker-compose.yml exec \
	--env DATABASE_URL=postgresql://postgres:postgres@db/wellio-fit-test app \
	bundle exec rake db:drop db:create db:migrate

local.shell:
	@$(call MSG, "Starting [development] shell")
	docker-compose -f docker-compose.yml exec app sh

local.logs:
	@$(call MSG, "Showing [development] logs")
	docker-compose -f docker-compose.yml logs -f app

local.down:
	@$(call MSG, "Stopping local development environment")
	docker-compose -f docker-compose.yml down

local.clean:
	@$(call MSG, "Cleaning local development environment")
	docker-compose -f docker-compose.yml rm --force --stop
	docker-compose -f docker-compose.yml down --volumes --remove-orphans

local.test:
	@$(call MSG, "Running [test] suite")
	docker-compose -f docker-compose.yml exec app make test.run SPEC=${SPEC}

local.recycle: local.recycle.shell

local.recycle.shell:
	@$(call MSG, "Recycling [development] shell")
	@make local.down
	@make local.up local.setup
	@make local.shell

### UNIT TESTS ###

# Unit test runner for local development environment
test.run:
	bundle exec rspec $(SPEC)
