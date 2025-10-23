import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokemon_test/core/error/exceptions.dart';
import 'package:pokemon_test/core/network/dio_client.dart';

abstract class BaseRemoteDataSource {
  final DioClient client;

  BaseRemoteDataSource(this.client);

  Future<List<T>> getList<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    String? resultsKey = 'results',
  }) async {
    try {
      final resp = await client.get(path);

      if (resp.data == null || resp.data[resultsKey] == null) {
        throw ServerException('Invalid API response: No $resultsKey found');
      }

      final results = resp.data[resultsKey];
      if (results is! List) {
        throw ServerException(
          'Invalid API response: $resultsKey is not a list',
        );
      }

      return results.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw ServerException('Unexpected error occurred: $e');
    }
  }

  Future<List<T>> getListFromKey<T>({
    required String path,
    required String dataKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final resp = await client.get(path);

      if (resp.data == null || resp.data[dataKey] == null) {
        throw ServerException('Invalid API response: No $dataKey found');
      }

      final results = resp.data[dataKey];
      if (results is! List) {
        throw ServerException('Invalid API response: $dataKey is not a list');
      }

      return results.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw ServerException('Unexpected error occurred: $e');
    }
  }

  Future<T> getObject<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final resp = await client.get(path);

      if (resp.data == null) {
        throw ServerException('Invalid API response: Empty body');
      }

      return fromJson(Map<String, dynamic>.from(resp.data));
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw ServerException('Unexpected error occurred: $e');
    }
  }

  Never _handleDioError(DioException e) {
    String errorMessage;
    int? statusCode = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage =
            'Connection timeout. Please check your internet and try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleHttpError(statusCode);
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection. Please check your network.';
        break;
      default:
        errorMessage = e.message ?? 'Unexpected network error';
    }

    if (kDebugMode) {
      debugPrint('DataSource Error: $errorMessage (Status: $statusCode)');
    }
    throw ServerException(errorMessage, statusCode: statusCode);
  }

  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please try again.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 403:
        return 'Forbidden. You do not have access to this resource.';
      case 404:
        return 'Resource not found. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Unexpected server error. Please try again.';
    }
  }
}
