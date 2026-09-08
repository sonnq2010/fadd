.PHONY: gen-code gen-locale-keys gen-api-client check-api-client check-code check-generated analyze test verify

gen-code:
	fvm dart run build_runner build --delete-conflicting-outputs
	$(MAKE) gen-locale-keys

gen-locale-keys:
	fvm dart run easy_localization:generate -S assets/translations -s en.json -O lib/generated -o locale_keys.g.dart -f keys -u

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
	fvm dart run custom_lint

test:
	fvm flutter test --coverage

verify: check-generated analyze test
