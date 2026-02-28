import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'app_exception.dart';

class ErrorHandler {
  static AppException handle(DioException error) {
    String message = 'Something went wrong';
    int? statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;

      case DioExceptionType.sendTimeout:
        message = 'Request timeout';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'Response timeout';
        break;

      case DioExceptionType.badResponse:
        if (error.response?.data != null &&
            error.response?.data['message'] != null) {
          message = error.response?.data['message'];
        } else {
          message = 'Server error';
        }
        break;

      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;

      case DioExceptionType.unknown:
        message = 'No internet connection';
        break;

      default:
        message = 'Unexpected error';
    }

    return AppException(
      message: message,
      statusCode: statusCode,
    );
  }

  /// 🔹 Show global snackbar
  static void showError(AppException exception) {
    Get.snackbar(
      'Error',
      exception.message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}