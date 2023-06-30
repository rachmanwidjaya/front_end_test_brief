import 'package:dartz/dartz.dart';

import '../entities/remote_config_entity.dart';

abstract class RemoteConfigRepository {
  Future<Either<Exception, RemoteConfigEntity>> load();
}
