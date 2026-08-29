import 'package:api_client/api_client.dart';
import 'package:mobileapp/core/configs/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(basePathOverride: AppConfig.apiBaseUrl);
}
