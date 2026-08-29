.PHONY: gen-api-client gen-i18n verify

gen-api-client:
	$(MAKE) -C src/backend gen-swagger
	npm --prefix src/webapp run api:generate

gen-i18n:
	npm --prefix src/webapp run i18n:generate

verify:
	@echo "Verifying the project..."
	$(MAKE) -C src/backend verify
	$(MAKE) -C src/webapp verify
