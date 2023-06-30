import 'package:dartz/dartz.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../domain/entities/remote_config_entity.dart';
import '../../../domain/repository/remote_config_repository.dart';

class DumyRemoteConfigRepositoryImpl implements RemoteConfigRepository {
  static final _singleton = DumyRemoteConfigRepositoryImpl();
  static DumyRemoteConfigRepositoryImpl get instance => _singleton;
  @override
  Future<Either<Exception, RemoteConfigEntity>> load() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Right(
        RemoteConfigEntity(
          appServer: '',
          appOpen: true,
          forceUpdate: false,
          appUpdate: false,
          appVersion: 1,
          versionValid: true,
        ),
      );
    } catch (e, s) {
      return Left(
        AppException(
          errorCode: '001',
          message: 'Failed to obtain the config.',
          error: e,
          stackTrace: s,
        ),
      );
    }
  }
}
