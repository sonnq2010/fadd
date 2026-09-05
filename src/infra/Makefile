SHELL := /bin/bash

TERRAFORM_DIRS := $(shell find aws gcp -type f -name terraform.tf -exec dirname {} \; | sort -u)
TEST_DIRS := aws/modules/platform gcp/modules/platform
TFLINT_IMAGE ?= ghcr.io/terraform-linters/tflint:v0.59.1
TRIVY_IMAGE ?= aquasec/trivy:0.74.0
TF_PLUGIN_CACHE_DIR ?= /tmp/fadd-terraform-plugin-cache

.PHONY: fmt fmt-check init validate lint security test verify

fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -check -recursive

init:
	@mkdir -p "$(TF_PLUGIN_CACHE_DIR)"
	@for dir in $(TERRAFORM_DIRS); do \
		echo "Initializing $$dir"; \
		TF_PLUGIN_CACHE_DIR="$(TF_PLUGIN_CACHE_DIR)" terraform -chdir="$$dir" init -backend=false -input=false >/dev/null; \
	done

validate: init
	@for dir in $(TERRAFORM_DIRS); do \
		echo "Validating $$dir"; \
		terraform -chdir="$$dir" validate; \
	done

lint:
	docker run --rm -v "$(CURDIR):/data" -w /data $(TFLINT_IMAGE) --recursive --config /data/.tflint.hcl

security:
	docker run --rm -v "$(CURDIR):/work" $(TRIVY_IMAGE) config --exit-code 1 --severity HIGH,CRITICAL /work

test: init
	@for dir in $(TEST_DIRS); do \
		echo "Testing $$dir"; \
		terraform -chdir="$$dir" test; \
	done

verify: fmt-check validate lint security test
