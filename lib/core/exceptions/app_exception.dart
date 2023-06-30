import 'dart:developer';

class AppException implements Exception {
  /// message for user
  final String? message;

  /// errorCode for user
  final String? errorCode;

  ///error for Log and FirebaseCrashlytics
  final Object? error;

  ///stackTrace for Log and FirebaseCrashlytics
  final StackTrace? stackTrace;

  ///stackTrace for FirebaseCrashlytics
  final dynamic reason;

  ///stackTrace for FirebaseCrashlytics
  final Iterable<Object> information;

  ///stackTrace for FirebaseCrashlytics
  final bool? fatal;

  AppException({
    this.message,
    this.errorCode,
    this.error,
    this.stackTrace,
    this.reason,
    this.information = const [],
    this.fatal,
  }) : super() {
    log('$message', error: error, stackTrace: stackTrace);
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: fatal, reason: reason);
  }

  @override

  ///This method will return the value
  ///```dart
  ///String toString() => "${errorCode != null ? "$errorCode :" : ''}$message";
  ///```
  /// for user needs

  String toString() => "${errorCode != null ? "$errorCode :" : ''}$message";
}
