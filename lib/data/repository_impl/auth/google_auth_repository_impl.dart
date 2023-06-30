// import 'package:dartz/dartz.dart';

// import '../../../core/exceptions/app_exception.dart';
// import '../../../domain/entities/user_entity.dart';
// import '../../../domain/repository/auth_repository.dart';

// class GoogleAuthRepositoryImpl implements AuthRepository {
//   @override
//   Future<Either<Exception, UserEntity?>> validate() async {
//     try {
//       // return Right(UserModel.fromFirebaseAuth(user));
//       throw UnimplementedError();
//     } catch (e, s) {
//       return Left(
//           AppException(message: 'Validate Failed', error: e, stackTrace: s));
//     }
//   }

//   @override
//   Future<Either<Exception, bool>> signOut() async {
//     try {
//       // await FirebaseAuth.instance.signOut();
//       return const Right(true);
//     } catch (e, s) {
//       return Left(
//           AppException(message: 'SignOut Failed', error: e, stackTrace: s));
//     }
//   }

//   @override
//   Future<Either<Exception, UserEntity>> signIn() {
//     throw UnimplementedError();
//   }
// }
