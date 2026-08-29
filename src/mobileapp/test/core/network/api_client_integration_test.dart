import 'dart:convert';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/exceptions/failure.dart';

void main() {
  late HttpServer server;
  late Future<void> Function(HttpRequest request) handleRequest;
  late ApiClient client;

  setUp(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) => handleRequest(request));
    client = ApiClient(
      basePathOverride: 'http://${server.address.host}:${server.port}',
    );
  });

  tearDown(() => server.close(force: true));

  test('calls and deserializes the health endpoint', () async {
    handleRequest = (request) async {
      expect(request.method, 'GET');
      expect(request.uri.path, '/api/v1/health');
      request.response.headers.contentType = ContentType.json;
      request.response.write(
        jsonEncode({'status': 'ok', 'version': 'test'}),
      );
      await request.response.close();
    };

    final response = await client.getHealthApi().healthGetHealth();

    expect(response.data?.status, 'ok');
    expect(response.data?.version, 'test');
  });

  test('sends bearer authorization to the user endpoint', () async {
    handleRequest = (request) async {
      expect(request.method, 'GET');
      expect(request.uri.path, '/api/v1/users/user-1');
      expect(
        request.headers.value(HttpHeaders.authorizationHeader),
        'Bearer access-token',
      );
      request.response.headers.contentType = ContentType.json;
      request.response.write(
        jsonEncode({
          'id': 'user-1',
          'email': 'user@example.com',
          'displayName': 'Example User',
          'createdAt': '2026-08-29T00:00:00Z',
          'updatedAt': '2026-08-29T00:00:00Z',
        }),
      );
      await request.response.close();
    };
    client.setApiKey('bearerAuth', 'Bearer access-token');

    final response = await client.getUsersApi().usersGetUser(id: 'user-1');

    expect(response.data?.id, 'user-1');
    expect(response.data?.email, 'user@example.com');
  });

  test(
    'maps generated 401 errors through the shared failure boundary',
    () async {
      handleRequest = (request) async {
        request.response.statusCode = HttpStatus.unauthorized;
        request.response.headers.contentType = ContentType.json;
        request.response.write(jsonEncode({'message': 'Invalid token'}));
        await request.response.close();
      };

      try {
        await client.getUsersApi().usersGetUser(id: 'user-1');
        fail('Expected DioException');
      } on DioException catch (error, stackTrace) {
        final result = Failure.handleException<void>(error, stackTrace);

        result.fold(
          (failure) => expect(failure, isA<UnauthorizedFailure>()),
          (_) => fail('Expected an unauthorized failure'),
        );
      }
    },
  );
}
