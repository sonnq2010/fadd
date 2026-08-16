import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network({
    required String message,
    int? statusCode,
    StackTrace? stackTrace,
  }) = NetworkFailure;

  const factory Failure.server({
    required String message,
    int? statusCode,
    StackTrace? stackTrace,
  }) = ServerFailure;

  const factory Failure.cache({
    required String message,
    StackTrace? stackTrace,
  }) = CacheFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? errors,
  }) = ValidationFailure;

  const factory Failure.unauthorized({
    required String message,
    StackTrace? stackTrace,
  }) = UnauthorizedFailure;

  const factory Failure.notFound({
    required String message,
    StackTrace? stackTrace,
  }) = NotFoundFailure;

  const factory Failure.timeout({
    required String message,
    StackTrace? stackTrace,
  }) = TimeoutFailure;

  const factory Failure.unexpected({
    required String message,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;

  /// Handles errors and returns appropriate Failure type
  static Either<Failure, T> handleException<T>(
    Object error, [
    StackTrace? stackTrace,
  ]) {
    // Handle Dio exceptions
    if (error is DioException) {
      return Left(_handleDioException(error, stackTrace));
    }

    // Handle Supabase Auth exceptions
    if (error is AuthException) {
      return Left(_handleAuthException(error, stackTrace));
    }

    // Handle Supabase Postgrest exceptions
    if (error is PostgrestException) {
      return Left(_handlePostgrestException(error, stackTrace));
    }

    // Handle Supabase Storage exceptions
    if (error is StorageException) {
      return Left(_handleStorageException(error, stackTrace));
    }

    // Handle Supabase Functions exceptions
    if (error is FunctionException) {
      return Left(_handleFunctionException(error, stackTrace));
    }

    // Handle format exceptions (JSON parsing, etc.)
    if (error is FormatException) {
      return Left(
        Failure.unexpected(
          message: 'Invalid data format: ${error.message}',
          stackTrace: stackTrace,
        ),
      );
    }

    // Handle type errors
    if (error is TypeError) {
      return Left(
        Failure.unexpected(
          message: 'Type error: ${error.toString()}',
          stackTrace: stackTrace,
        ),
      );
    }

    // Handle generic exceptions
    if (error is Exception) {
      return Left(
        Failure.unexpected(
          message: error.toString().replaceFirst('Exception: ', ''),
          stackTrace: stackTrace,
        ),
      );
    }

    // Handle any other errors
    return Left(
      Failure.unexpected(
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  /// Handles Dio-specific exceptions
  static Failure _handleDioException(
    DioException error, [
    StackTrace? stackTrace,
  ]) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure.timeout(
          message: error.message ?? 'Request timeout',
          stackTrace: stackTrace ?? error.stackTrace,
        );

      case DioExceptionType.connectionError:
        return Failure.network(
          message: error.message ?? 'No internet connection',
          stackTrace: stackTrace ?? error.stackTrace,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        final message = responseData is Map
            ? responseData['message'] as String?
            : null;

        // Handle specific status codes
        if (statusCode == 401) {
          return Failure.unauthorized(
            message: message ?? 'Unauthorized. Please login again.',
            stackTrace: stackTrace ?? error.stackTrace,
          );
        }

        if (statusCode == 404) {
          return Failure.notFound(
            message: message ?? 'Resource not found',
            stackTrace: stackTrace ?? error.stackTrace,
          );
        }

        if (statusCode == 422) {
          // Validation errors
          final errors = responseData is Map && responseData['errors'] is Map
              ? Map<String, String>.from(
                  (responseData['errors'] as Map).map(
                    (key, value) => MapEntry(
                      key.toString(),
                      value is List ? value.first.toString() : value.toString(),
                    ),
                  ),
                )
              : null;

          return Failure.validation(
            message: message ?? 'Validation error',
            errors: errors,
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return Failure.server(
            message: message ?? 'Server error. Please try again later.',
            statusCode: statusCode,
            stackTrace: stackTrace ?? error.stackTrace,
          );
        }

        return Failure.server(
          message: message ?? error.message ?? 'Something went wrong',
          statusCode: statusCode,
          stackTrace: stackTrace ?? error.stackTrace,
        );

      case DioExceptionType.cancel:
        return Failure.unexpected(
          message: 'Request cancelled',
          stackTrace: stackTrace ?? error.stackTrace,
        );

      case DioExceptionType.badCertificate:
        return Failure.network(
          message: 'Certificate verification failed',
          stackTrace: stackTrace ?? error.stackTrace,
        );

      case DioExceptionType.unknown:
        return Failure.unexpected(
          message: error.message ?? 'An unexpected error occurred',
          stackTrace: stackTrace ?? error.stackTrace,
        );
    }
  }

  /// Handles Supabase Auth exceptions
  static Failure _handleAuthException(
    AuthException error, [
    StackTrace? stackTrace,
  ]) {
    // Handle specific auth error codes
    switch (error.statusCode) {
      case '400':
        // Bad request - validation errors
        return Failure.validation(
          message: error.message,
          errors: null,
        );

      case '401':
        // Unauthorized
        return Failure.unauthorized(
          message: error.message,
          stackTrace: stackTrace,
        );

      case '404':
        // User not found
        return Failure.notFound(
          message: error.message,
          stackTrace: stackTrace,
        );

      case '422':
        // Unprocessable entity - validation
        return Failure.validation(
          message: error.message,
          errors: null,
        );

      case '429':
        // Too many requests
        return Failure.server(
          message: 'Too many requests. Please try again later.',
          statusCode: 429,
          stackTrace: stackTrace,
        );

      default:
        // Check for specific error messages
        final message = error.message.toLowerCase();

        if (message.contains('invalid login credentials') ||
            message.contains('invalid email or password')) {
          return Failure.unauthorized(
            message: 'Invalid email or password',
            stackTrace: stackTrace,
          );
        }

        if (message.contains('email not confirmed')) {
          return Failure.validation(
            message: 'Please verify your email address',
            errors: null,
          );
        }

        if (message.contains('user already registered')) {
          return Failure.validation(
            message: 'This email is already registered',
            errors: null,
          );
        }

        if (message.contains('network')) {
          return Failure.network(
            message: error.message,
            stackTrace: stackTrace,
          );
        }

        return Failure.server(
          message: error.message,
          statusCode: int.tryParse(error.statusCode ?? ''),
          stackTrace: stackTrace,
        );
    }
  }

  /// Handles Supabase Postgrest exceptions (Database queries)
  static Failure _handlePostgrestException(
    PostgrestException error, [
    StackTrace? stackTrace,
  ]) {
    final code = error.code;
    final message = error.message;

    // Handle specific Postgres error codes
    if (code != null) {
      // 23505 - Unique violation
      if (code == '23505') {
        return Failure.validation(
          message: 'This record already exists',
          errors: null,
        );
      }

      // 23503 - Foreign key violation
      if (code == '23503') {
        return Failure.validation(
          message: 'Cannot perform this action due to related records',
          errors: null,
        );
      }

      // 42501 - Insufficient privileges
      if (code == '42501') {
        return Failure.unauthorized(
          message: 'You do not have permission to perform this action',
          stackTrace: stackTrace,
        );
      }

      // PGRST116 - Row not found
      if (code == 'PGRST116') {
        return Failure.notFound(
          message: 'Record not found',
          stackTrace: stackTrace,
        );
      }
    }

    return Failure.server(
      message: message,
      stackTrace: stackTrace,
    );
  }

  /// Handles Supabase Storage exceptions
  static Failure _handleStorageException(
    StorageException error, [
    StackTrace? stackTrace,
  ]) {
    final message = error.message.toLowerCase();

    if (message.contains('not found')) {
      return Failure.notFound(
        message: 'File not found',
        stackTrace: stackTrace,
      );
    }

    if (message.contains('unauthorized') || message.contains('permission')) {
      return Failure.unauthorized(
        message: 'You do not have permission to access this file',
        stackTrace: stackTrace,
      );
    }

    if (message.contains('size') || message.contains('too large')) {
      return Failure.validation(
        message: 'File size exceeds the allowed limit',
        errors: null,
      );
    }

    return Failure.server(
      message: error.message,
      statusCode: error.statusCode != null
          ? int.tryParse(error.statusCode!)
          : null,
      stackTrace: stackTrace,
    );
  }

  /// Handles Supabase Functions exceptions (Edge Functions)
  static Failure _handleFunctionException(
    FunctionException error, [
    StackTrace? stackTrace,
  ]) {
    return Failure.server(
      message: error.details?.toString() ?? 'Function execution error',
      stackTrace: stackTrace,
    );
  }

  /// Returns a user-friendly message
  String get userMessage => when(
    network: (message, _, __) => 'Network error. Please check your connection.',
    server: (message, statusCode, _) => statusCode != null && statusCode >= 500
        ? 'Server error. Please try again later.'
        : message,
    cache: (message, _) => 'Local data error. Please try again.',
    validation: (message, errors) => errors?.values.join('\n') ?? message,
    unauthorized: (message, _) => 'You are not authorized. Please login again.',
    notFound: (message, _) => 'Resource not found.',
    timeout: (message, _) => 'Request timeout. Please try again.',
    unexpected: (message, _) => 'An unexpected error occurred.',
  );
}
