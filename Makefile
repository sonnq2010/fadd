.PHONY: verify

verify:
	@echo "Verifying the project..."
	$(MAKE) -C src/go verify
