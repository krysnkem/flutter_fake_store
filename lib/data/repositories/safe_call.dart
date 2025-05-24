import 'package:dio/dio.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'dart:io';

mixin SafeCall {
  final _successCodes = [200, 201];

  Future<Result<T>> safeApiCall<T>(
      {required Future Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    try {
      final response = await apiCall();
      final statusCode = response.response.statusCode ?? 0;

      if (_successCodes.contains(statusCode) && response.data != null) {
        return Success(data: _parseApiData(response.data, fromJson));
      } else {
        return Failure(
          message: 'Unexpected error: ${response.response.statusMessage}',
          statusCode: statusCode,
        );
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final message = _parseDioError(dioError);
      return Failure(message: message, statusCode: statusCode);
    } on SocketException {
      return Failure(
        message: 'No internet connection. Please check your network.',
      );
    } catch (e) {
      return Failure(
        message: 'Something went wrong. Please try again later.\nDetails: $e',
      );
    }
  }

  String _parseDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending data.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final data = error.response?.data;
        if (data is Map && data['message'] != null) {
          return data['message'];
        }
        return 'Server returned an error (Status Code: $statusCode).';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'Bad SSL certificate.';
      case DioExceptionType.connectionError:
        // Attempt to extract socket error message
        if (error.error is SocketException) {
          return 'No internet connection. Please check your network.';
        }
        return 'Failed to connect to the server.';
      case DioExceptionType.unknown:
        // Handle possible socket error
        if (error.error is SocketException) {
          return 'No internet connection. Please check your network.';
        }
        return 'An unknown error occurred.';
    }
  }

  T _parseApiData<T>(dynamic json, T Function(dynamic) fromJson) {
    return fromJson(json);
  }
}
