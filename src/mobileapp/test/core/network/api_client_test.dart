import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/configs/app_config.dart';
import 'package:mobileapp/core/network/api_client.dart';

void main() {
  test('provides a generated client with the configured base URL', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final client = container.read(apiClientProvider);

    expect(client, isA<ApiClient>());
    expect(client.dio.options.baseUrl, AppConfig.apiBaseUrl);
  });

  test('can be overridden by feature tests', () {
    final override = ApiClient(basePathOverride: 'http://localhost');
    final container = ProviderContainer(
      overrides: [apiClientProvider.overrideWithValue(override)],
    );
    addTearDown(container.dispose);

    expect(container.read(apiClientProvider), same(override));
  });
}
