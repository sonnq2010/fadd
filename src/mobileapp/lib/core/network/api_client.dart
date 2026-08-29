import 'package:backend_api_client/backend_api_client.dart';
import 'package:mobileapp/core/configs/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
BackendApiClient apiClient(Ref ref) {
  return BackendApiClient(basePathOverride: AppConfig.apiBaseUrl);
}
