import 'package:dartz/dartz.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../domain/entities/remote_config_entity.dart';
import '../../../domain/repository/remote_config_repository.dart';

class FirebaseRemoteConfigRepositoryImpl implements RemoteConfigRepository {
  @override
  Future<Either<Exception, RemoteConfigEntity>> load() async {
    try {
      throw UnimplementedError();
      // FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      // await remoteConfig.fetchAndActivate();
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // int clientVersion = int.parse(packageInfo.version.replaceAll('.', ''));
      // return Right(
      //   RemoteConfigEntity(
      //     appVersion: packageInfo.version,
      //     appUpdate: remoteConfig.getInt('lastVersion') > clientVersion,
      //     versionValid:
      //         clientVersion < (remoteConfig.getInt('lastVersion') + 1),
      //     forceUpdate: remoteConfig.getInt('minVersion') > clientVersion,
      //     updateLink: remoteConfig.getString('downloadLink'),
      //     appOpen: remoteConfig.getBool('open'),
      //     appServer: remoteConfig.getString('appServer'),
      //   ),
      // );
    } catch (e, s) {
      return Left(AppException(
          message: 'Failed to obtain the config.', error: e, stackTrace: s));
    }
  }
}
