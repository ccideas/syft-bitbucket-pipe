DOCKER ?= docker
PWD ?= pwd
NPM ?= npm
SAMPLE_JSON ?= sample.json

.PHONY: clean
clean:
	rm -rf sbom_output
	rm -rf output
	rm -rf build
	rm -rf node_modules
	rm package.json package-lock.json || echo "not found"

.PHONY: docker
docker:
	$(DOCKER) build --build-arg ARCH=arm64 --tag syft-bitbucket-pipe:dev .

.PHONY: docker-amd64
docker-amd64:
	$(DOCKER) buildx build --platform linux/amd64 --build-arg ARCH=amd64 --tag syft-bitbucket-pipe:dev .

.PHONY: docker-lint
docker-lint:
	$(DOCKER) run --rm -it \
		-v "$(shell pwd)":/build \
		--workdir /build \
		hadolint/hadolint:v2.12.0-alpine hadolint Dockerfile*

.PHONY: shellcheck
shellcheck:
	$(DOCKER) run --rm -it \
		-v $(PWD):/build \
		--workdir /build \
		koalaman/shellcheck-alpine:v0.9.0 shellcheck -x ./*.sh

.PHONY: markdown-lint
markdown-lint:
	$(DOCKER) run --rm -it \
		-v "$(shell pwd)":/build \
		--workdir /build \
		markdownlint/markdownlint:0.13.0 *.md

.PHONY: docker-debug
docker-debug:
	$(DOCKER) run --rm -it \
	    --volume $(PWD)/samples:/tmp/samples \
		--workdir /tmp \
		--entrypoint ash \
		--env-file variables.list \
		syft-bitbucket-pipe:dev

.PHONY: scan-project
scan-project:
	$(DOCKER) run --rm -it \
		-v $(PWD)/samples:/tmp/samples \
		--workdir /tmp \
		--env-file variables.list \
		syft-bitbucket-pipe:dev
