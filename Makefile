
DOCKER_REGISTRY ?= "technosophos"

.PHONY: build
build:
	mkdir -p bin/
	go build -o bin/slack-notify ./main.go

.PHONY: docker-build
docker-build:
	mkdir -p rootfs
	GOOS=linux GOARCH=amd64 go build -o rootfs/slack-notify ./main.go
	docker build -t $(DOCKER_REGISTRY)/slack-notify:latest .

.PHONY: docker-push
docker-push:
	docker push $(DOCKER_REGISTRY)/slack-notify

.PHONY: bootstrap
bootstrap:


