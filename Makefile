SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help
define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-40s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help: ## Print this help
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.PHONY: hooks
hooks:
	test -f .git/hooks/pre-commit || cp hooks/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

.PHONY: bootstrap
bootstrap: hooks  ## Build development environment
	pip install -r requirements.txt

.PHONY: bootstrap-ci
bootstrap-ci:  ## Build environment for CI
	pip install -r requirements-ci.txt

.PHONY: lint
lint:  ## Check code style
	yamllint \
		.github/workflows
	terraform fmt -check -recursive

.PHONY: format
format:  ## Format terraform files
	terraform fmt -recursive

.PHONY: init
init:
	echo -n "Using: "
	terraform --version
	terraform init -input=false

.PHONY: plan
plan: init ## Run terraform plan
	set -o pipefail ; terraform plan -no-color --out=tf.plan 2> plan.stderr | tee plan.stdout || (cat plan.stderr; exit 1)

.PHONY: apply
apply: ## Run terraform apply
	terraform apply -auto-approve -no-color -input=false tf.plan