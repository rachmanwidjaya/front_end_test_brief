import 'dart:convert';

import '../../config/enum/http_method.dart';
import '../../core/exceptions/app_exception.dart';

abstract class ApiRepository {
  Future<String> request(
    String endPoint, {
    HTTPMethod? method,
    Map<String, String>? headers,
    dynamic body,
  });
}

extension ApiRepositoryExtension on ApiRepository {
  String handleResponse(int statusCode, String responseBody) {
    if (statusCode == 200) {
      return responseBody;
    } else {
      String message = 'Error';
      try {
        message = json.decode(responseBody)['message'];
      } catch (_) {
        message = _handleError(statusCode);
      }
      throw AppException(message: message);
    }
  }

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthenticated';
      case 402:
        return 'Payment required';
      case 403:
        return 'Forbidden';
      case 404:
        return "Page not found";
      case 405:
        return "Method not allowed";
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
