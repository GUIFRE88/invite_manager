up:
	docker compose up

down:
	docker compose down

bash:
	docker exec -it web bash

test:
	docker exec -it web bash -c "RAILS_ENV=test rspec"