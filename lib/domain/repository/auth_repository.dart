import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity?>> validate();
  Future<Either<Exception, bool>> signOut();
  Future<Either<Exception, UserEntity>> signIn();
}
