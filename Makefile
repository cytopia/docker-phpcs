ifneq (,)
.error This Makefile requires GNU Make.
endif

# Ensure additional Makefiles are present
MAKEFILES = Makefile.docker Makefile.lint
$(MAKEFILES): URL=https://raw.githubusercontent.com/devilbox/makefiles/master/$(@)
$(MAKEFILES):
	@if ! (curl --fail -sS -o $(@) $(URL) || wget -O $(@) $(URL)); then \
		echo "Error, curl or wget required."; \
		echo "Exiting."; \
		false; \
	fi
include $(MAKEFILES)

# Set default Target
.DEFAULT_GOAL := help


# -------------------------------------------------------------------------------------------------
# Default configuration
# -------------------------------------------------------------------------------------------------
# Own vars
TAG        = latest

# Makefile.docker overwrites
NAME       = phpcs
VERSION    = latest
IMAGE      = cytopia/phpcs
FLAVOUR    = latest
FILE       = Dockerfile.${FLAVOUR}
DIR        = Dockerfiles

# Extract PHP- and PCS- version from VERSION string
ifeq ($(strip $(VERSION)),latest)
	PHP_VERSION = latest
	PCS_VERSION = latest
	IMG_VERSION = ""
else
	PHP_VERSION = $(subst PHP-,,$(shell echo "$(VERSION)" | grep -Eo 'PHP-([.0-9]+|latest)'))
	PCS_VERSION = $(subst PCS-,,$(shell echo "$(VERSION)" | grep -Eo 'PCS-([.0-9]+|latest)'))
	IMG_VERSION = $(PHP_VERSION)-
endif

# Building from master branch: Tag == 'latest'
ifeq ($(strip $(TAG)),latest)
	ifeq ($(strip $(VERSION)),latest)
		DOCKER_TAG = $(FLAVOUR)
	else
		ifeq ($(strip $(FLAVOUR)),latest)
			ifeq ($(strip $(PHP_VERSION)),latest)
				DOCKER_TAG = $(PCS_VERSION)
			else
				DOCKER_TAG = $(PCS_VERSION)-php$(PHP_VERSION)
			endif
		else
			ifeq ($(strip $(PHP_VERSION)),latest)
				DOCKER_TAG = $(FLAVOUR)-$(PCS_VERSION)
			else
				DOCKER_TAG = $(FLAVOUR)-$(PCS_VERSION)-php$(PHP_VERSION)
			endif
		endif
	endif
# Building from any other branch or tag: Tag == '<REF>'
else
	ifeq ($(strip $(VERSION)),latest)
		ifeq ($(strip $(FLAVOUR)),latest)
			DOCKER_TAG = latest-$(TAG)
		else
			DOCKER_TAG = $(FLAVOUR)-latest-$(TAG)
		endif
	else
		ifeq ($(strip $(FLAVOUR)),latest)
			ifeq ($(strip $(PHP_VERSION)),latest)
				DOCKER_TAG = $(PCS_VERSION)-$(TAG)
			else
				DOCKER_TAG = $(PCS_VERSION)-php$(PHP_VERSION)-$(TAG)
			endif
		else
			ifeq ($(strip $(PHP_VERSION)),latest)
				DOCKER_TAG = $(FLAVOUR)-$(PCS_VERSION)-$(TAG)
			else
				DOCKER_TAG = $(FLAVOUR)-$(PCS_VERSION)-php$(PHP_VERSION)-$(TAG)
			endif
		endif
	endif
endif

# Makefile.lint overwrites
FL_IGNORES  = .git/,.github/,tests/
SC_IGNORES  = .git/,.github/,tests/
JL_IGNORES  = .git/,.github/,./tests/


# -------------------------------------------------------------------------------------------------
#  Default Target
# -------------------------------------------------------------------------------------------------
.PHONY: help
help:
	@echo "lint                                     Lint project files and repository"
	@echo
	@echo "build [ARCH=...] [TAG=...]               Build Docker image"
	@echo "rebuild [ARCH=...] [TAG=...]             Build Docker image without cache"
	@echo "push [ARCH=...] [TAG=...]                Push Docker image to Docker hub"
	@echo
	@echo "manifest-create [ARCHES=...] [TAG=...]   Create multi-arch manifest"
	@echo "manifest-push [TAG=...]                  Push multi-arch manifest"
	@echo
	@echo "test [ARCH=...]                          Test built Docker image"
	@echo


# -------------------------------------------------------------------------------------------------
#  Target Overrides
# -------------------------------------------------------------------------------------------------
.PHONY: docker-pull-base-image
docker-pull-base-image:
	@echo "################################################################################"
	@echo "# Pulling Base Image php:$(IMG_VERSION)cli-alpine (platform: $(ARCH))"
	@echo "################################################################################"
	@echo "docker pull --platform $(ARCH) php:$(IMG_VERSION)cli-alpine"; \
	while ! docker pull --platform $(ARCH) php:$(IMG_VERSION)cli-alpine; do sleep 1; done \


# -------------------------------------------------------------------------------------------------
#  Docker Targets
# -------------------------------------------------------------------------------------------------
.PHONY: build
build: ARGS+=--build-arg PCS_VERSION=$(PCS_VERSION)
build: ARGS+=--build-arg PHP_VERSION=$(IMG_VERSION)
build: docker-arch-build

.PHONY: rebuild
rebuild: ARGS+=--build-arg PCS_VERSION=$(PCS_VERSION)
rebuild: ARGS+=--build-arg PHP_VERSION=$(IMG_VERSION)
rebuild: docker-arch-rebuild

.PHONY: push
push: docker-arch-push


# -------------------------------------------------------------------------------------------------
#  Manifest Targets
# -------------------------------------------------------------------------------------------------
.PHONY: manifest-create
manifest-create: docker-manifest-create

.PHONY: manifest-push
manifest-push: docker-manifest-push


# -------------------------------------------------------------------------------------------------
#  Test Targets
# -------------------------------------------------------------------------------------------------
.PHONY: test
test:
test: _test-phpcs-version
test: _test-php-version
test: _test-run

.PHONY: _test-phpcs-version
_test-phpcs-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct phpcs version"
	@echo "------------------------------------------------------------"
	@if [ "$(PCS_VERSION)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
		curl -L -sS https://github.com/squizlabs/PHP_CodeSniffer/releases \
			| tac | tac \
			| grep -Eo '/[.0-9]+?\.[.0-9]+"' \
			| grep -Eo '[.0-9]+' \
			| sort -V \
			| tail -1 \
		)"; \
		echo "Testing for latest: $${LATEST}"; \
		if ! docker run --rm --platform $(ARCH) $(IMAGE):$(DOCKER_TAG) --version | grep -E "^PHP_CodeSniffer[[:space:]]+version[[:space:]]+v?$${LATEST}"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(PCS_VERSION).x.x"; \
		if ! docker run --rm --platform $(ARCH) $(IMAGE):$(DOCKER_TAG) --version | grep -E "^PHP_CodeSniffer[[:space:]]+version[[:space:]]+v?$(PCS_VERSION)\.[.0-9]+"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

.PHONY: _test-php-version
_test-php-version: _get-php-version
	@echo "------------------------------------------------------------"
	@echo "- Testing correct PHP version"
	@echo "------------------------------------------------------------"
	@echo "Testing for tag: $(CURRENT_PHP_VERSION)"
	@if ! docker run --rm --platform $(ARCH) --entrypoint=php $(IMAGE):$(DOCKER_TAG) --version | head -1 | grep -E "^PHP[[:space:]]+$(CURRENT_PHP_VERSION)([.0-9]+)?"; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

.PHONY: _test-run
_test-run:
	@echo "------------------------------------------------------------"
	@echo "- Testing phpcs (success)"
	@echo "------------------------------------------------------------"
	@if ! docker run --rm --platform $(ARCH) -v $(CURRENT_DIR)/tests/ok:/data $(IMAGE):$(DOCKER_TAG) .; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";
	@echo "------------------------------------------------------------"
	@echo "- Testing phpcs (failure)"
	@echo "------------------------------------------------------------"
	@if docker run --rm --platform $(ARCH) -v $(CURRENT_DIR)/tests/fail:/data $(IMAGE):$(DOCKER_TAG) .; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

# Fetch latest available PHP version for cli-alpine
.PHONY: _get-php-version
_get-php-version:
	$(eval CURRENT_PHP_VERSION = $(shell \
		if [ "$(PHP)" = "latest" ]; then \
			curl -L -sS https://hub.docker.com/api/content/v1/products/images/php \
				| tac | tac \
				| grep -Eo '`[.0-9]+-cli-alpine' \
				| grep -Eo '[.0-9]+' \
				| sort -u \
				| tail -1; \
		else \
			echo $(PHP); \
		fi; \
	))
