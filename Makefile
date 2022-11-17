.DEFAULT_GOAL:=help

##@ Testing
test:   ## Test with pytest
	pytest -n auto -vvv -s -x

coverage: ## Show Test Coverage
	coverage run --skip-covered -m pytest -v && \
	coverage report -m && \
	rm -rf .coverage

##@ Linting
format: ## Format Code
	@echo "Running black..."
	black .

lint: ## Lint Code
	@echo "Running flake8..."
	flake8 . --ignore=E266,W503,E203,E501,W605,E128 --exclude contrib
	@echo "Running black... "
	black --check .
	@echo "Running pylint..."
	pylint --disable=W,C,R,E -j 0 providers lib util config

##@ Help
help:     ## Show this help.
	@echo "Prowler Makefile"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)