import 'app_exception.dart';

class ParserException extends AppException {
  ParserException({
    super.errorCode,
    super.error,
    super.stackTrace,
    super.reason,
    super.information,
    super.fatal,
  }) : super(message: 'Parsing failed');
  @override
  String toString() => '$message';
}
