.PHONY: build up bash

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down -t 0

bash:
	docker-compose exec builder bash
