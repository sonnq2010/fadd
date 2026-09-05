.PHONY: verify
verify:
	@echo "Verifying the project..."
	$(MAKE) -C src/backend verify
	$(MAKE) -C src/webapp verify
	$(MAKE) -C src/mobileapp verify
	$(MAKE) -C src/infra verify
