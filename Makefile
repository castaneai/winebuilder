.PHONY: build up bash

build:
	docker-compose build

up:
	docker-compose up -d

bash:
	docker-compose exec builder bash
