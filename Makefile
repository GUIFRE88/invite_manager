DOCKER_COMPOSE = docker-compose
RAILS_CONTAINER = web
RAILS_ENV = development
RAILS_ENV_TEST = test

up:
	docker compose up --build

down:
	docker compose down

bash:
	docker exec -it $(RAILS_CONTAINER) bash

test:
	docker exec -it $(RAILS_CONTAINER) bash -c "RAILS_ENV=test rspec"

db_create:
	docker exec -it $(RAILS_CONTAINER) bash -c "rails db:create"

db_migrate:
	docker exec -it $(RAILS_CONTAINER) bash -c "rails db:migrate"

setup:
	docker exec -it $(RAILS_CONTAINER) bash -c "rails db:create && rails db:migrate"

setup_test:
	docker exec -it $(RAILS_CONTAINER) bash -c "RAILS_ENV=test rails db:create && rails db:migrate"

build:
	docker compose build

start:
	docker compose up

rebuild_and_migrate:
	docker compose down
	docker compose up --build -d
	docker exec -it $(RAILS_CONTAINER) bash -c "rails db:create && rails db:migrate"

rebuild_and_migrate_test:
	docker compose down
	docker compose up --build -d
	docker exec -it $(RAILS_CONTAINER) bash -c "RAILS_ENV=test rails db:create && rails db:migrate"
