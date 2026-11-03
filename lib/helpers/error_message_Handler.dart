// ignore_for_file: file_names

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:location_tracker/common_widgets/custom_toast.dart';

final class ErrorMessageHandler {
  ErrorMessageHandler._();

  static String handle(dynamic error) {
    String message = "Something went wrong. Please try again.";
    log(error.toString());

    if (error is DioException) {
      if (error.response?.data != null && error.response?.data is Map) {
        final data = error.response?.data as Map;
        message =
            data["message"]?.toString() ??
            data["error"]?.toString() ??
            data["detail"]?.toString() ??
            message;
      } else if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout) {
        message = "Check Your Network Connection";
      } else if (error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        message = "Request timed out. Please try again.";
      }
    }

    customToastMessage("Error", message);
    return message;
  }
}
