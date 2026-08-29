.PHONY: gen-code gen-api-client check-api-client check-code check-generated analyze test verify

gen-code:
	fvm dart run build_runner build --delete-conflicting-outputs

gen-api-client:
	./tool/generate_api_client.sh
	fvm flutter pub get

check-api-client:
	./tool/generate_api_client.sh --check

check-code:
	./tool/check_generated_code.sh

check-generated: check-api-client check-code

analyze:
	fvm dart analyze api-client
	fvm flutter analyze

test:
	fvm flutter test --coverage

verify: check-generated analyze test
