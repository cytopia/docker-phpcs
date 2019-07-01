ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: build rebuild lint test _test-phpcs-version _test-php-version _test-run tag pull login push enter

CURRENT_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

DIR = .
FILE = Dockerfile
IMAGE = cytopia/phpcs
TAG = latest

PHP   = latest
PHPCS = latest

build:
ifeq ($(PHP),latest)
	docker build --build-arg PHP=7-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
else
	docker build --build-arg PHP=$(PHP)-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
endif

rebuild: pull
ifeq ($(PHP),latest)
	docker build --no-cache --build-arg PHP=7-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
else
	docker build --no-cache --build-arg PHP=$(PHP)-cli-alpine --build-arg PHPCS=$(PHPCS) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)
endif

lint:
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-cr --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-crlf --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-trailing-single-newline --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-trailing-space --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-utf8 --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-utf8-bom --text --ignore '.git/,.github/,tests/' --path .

test:
	@$(MAKE) --no-print-directory _test-phpcs-version
	@$(MAKE) --no-print-directory _test-php-version
	@$(MAKE) --no-print-directory _test-run

_test-phpcs-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct phpcs version"
	@echo "------------------------------------------------------------"
	@if [ "$(PHPCS)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
		curl -L -sS https://github.com/squizlabs/PHP_CodeSniffer/releases \
			| tac | tac \
			| grep -Eo '/[.0-9]+?\.[.0-9]+/' \
			| grep -Eo '[.0-9]+' \
			| sort -V \
			| tail -1 \
		)"; \
		echo "Testing for latest: $${LATEST}"; \
		if ! docker run --rm $(IMAGE) --version | grep -E "^PHP_CodeSniffer[[:space:]]+version[[:space:]]+v?$${LATEST}"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(PHPCS).x.x"; \
		if ! docker run --rm $(IMAGE) --version | grep -E "^PHP_CodeSniffer[[:space:]]+version[[:space:]]+v?$(PHPCS)\.[.0-9]+"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

_test-php-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct PHP version"
	@echo "------------------------------------------------------------"
	@if [ "$(PHP)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
		curl -L -sS https://github.com/php/php-src/releases \
			| tac | tac \
			| grep -Eo '/php-[.0-9]+?\.[.0-9]+"' \
			| grep -Eo '[.0-9]+' \
			| sort -V \
			| tail -1 \
		)"; \
		echo "Testing for latest: $${LATEST}"; \
		if ! docker run --rm --entrypoint=php $(IMAGE) --version | head -1 | grep -E "^PHP[[:space:]]+$${LATEST}[[:space:]]"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(PHP).x"; \
		if ! docker run --rm --entrypoint=php $(IMAGE) --version | head -1 | grep -E "^PHP[[:space:]]+$(PHP)\.[.0-9]+[[:space:]]"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

_test-tg-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct Terragrunt version"
	@echo "------------------------------------------------------------"
	@if [ "$(TG_VERSION)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
			curl -L -sS https://github.com/gruntwork-io/terragrunt/releases \
			| tac | tac \
			| grep -Eo '/v[.0-9]+/' \
			| grep -Eo 'v[.0-9]+' \
			| sort -u \
			| sort -V \
			| tail -1 \
		)"; \
		echo "Testing for latest: $${LATEST}"; \
		if ! docker run --rm $(IMAGE) terragrunt --version | grep -E "^terragrunt[[:space:]]*version[[:space:]]*v?$${LATEST}$$"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(TG_VERSION)"; \
		if ! docker run --rm $(IMAGE) terragrunt --version | grep -E "^terragrunt[[:space:]]*version[[:space:]]*v?$(TG_VERSION)\.[.0-9]+$$"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

_test-run:
	@echo "------------------------------------------------------------"
	@echo "- Testing phpcs (success)"
	@echo "------------------------------------------------------------"
	@if ! docker run --rm -v $(CURRENT_DIR)/tests/ok:/data $(IMAGE) .; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";
	@echo "------------------------------------------------------------"
	@echo "- Testing phpcs (failure)"
	@echo "------------------------------------------------------------"
	@if docker run --rm -v $(CURRENT_DIR)/tests/fail:/data $(IMAGE) .; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

tag:
	docker tag $(IMAGE) $(IMAGE):$(TAG)

pull:
	@grep -E '^\s*FROM' Dockerfile \
		| sed -e 's/^FROM//g' -e 's/[[:space:]]*as[[:space:]]*.*$$//g' \
		| xargs -n1 docker pull;

login:
	yes | docker login --username $(USER) --password $(PASS)

push:
	@$(MAKE) tag TAG=$(TAG)
	docker push $(IMAGE):$(TAG)

enter:
	docker run --rm --name $(subst /,-,$(IMAGE)) -it --entrypoint=/bin/sh $(ARG) $(IMAGE):$(TAG)
