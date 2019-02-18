all:
	docker build --tag cadizm/ai-env .

run:
	docker-compose run --rm --workdir="/src" ai-env

push:
	docker push cadizm/ai-env

.PHONY: all run push
