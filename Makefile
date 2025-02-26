help: ## Show this help message
	@echo 'usage: make [target] <type> <name>'
	@echo
	@echo 'Targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

bundle : ## Create production bundle
	rm -rf dist || exit $? ; \
	node ./esbuild.js || exit $? ; \

format : ## Enforces a consistent style by parsing your code and re-printing it
	pnpx prettier --write "./src/**/*.js" "./tests/**/*.js" "./examples/**/*.js" ;\

static : ## Run a static page
	node -r esm examples/ssr/counter.js || exit $? ;\

server : ## Run a dev static server
	pnpx github:gc-victor/d-d#9adcf46bf2f346d7dd1f79758fe14064cc8b0734

test : ## Execute tests
	TEST=true node -r esm tests/index.js || exit $? ;\

test-ssr : ## Execute SSR tests
	node -r esm tests/index.js || exit $? ;\

test-watch : test ## Execute tests on watch mode
	npx chokidar-cli "**/*.js" -c "make test" || exit $? ;\

# catch anything and do nothing
%:
	@:
