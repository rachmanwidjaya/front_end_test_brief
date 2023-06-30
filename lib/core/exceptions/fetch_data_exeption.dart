import 'app_exception.dart';

class FetchDataExeption extends AppException {
  FetchDataExeption({
    super.message,
    super.errorCode,
    super.error,
    super.stackTrace,
    super.reason,
    super.information,
    super.fatal,
  });
}
