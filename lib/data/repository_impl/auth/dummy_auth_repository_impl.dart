// import 'dart:developer';

// import 'package:dartz/dartz.dart';

// import '../../../core/exceptions/app_exception.dart';
// import '../../../domain/entities/user_entity.dart';
// import '../../../domain/repository/auth_repository.dart';
// import '../../models/user_model.dart';

// class DummyAuthRepositiryImpl implements AuthRepository {
//   final String? token;
//   DummyAuthRepositiryImpl({required this.token});
//   @override
//   Future<Either<Exception, UserEntity?>> validate() async {
//     log('$token', name: 'AccsesToken');
//     try {
//       await Future.delayed(const Duration(seconds: 2));
//       // return const Right(null); //return UnAuthorized
//       return Right(token != null ? UserModel.dummyUser() : null);
//     } catch (e, s) {
//       return Left(
//           AppException(message: 'Validate Failed', error: e, stackTrace: s));
//     }
//   }

//   @override
//   Future<Either<Exception, bool>> signOut() async {
//     try {
//       return const Right(true);
//     } catch (e, s) {
//       return Left(
//           AppException(message: 'signOut Failed', error: e, stackTrace: s));
//     }
//   }

//   @override
//   Future<Either<Exception, UserEntity>> signIn() async {
//     try {
//       await Future.delayed(const Duration(seconds: 2));
//       return Right(UserModel.dummyUser());
//     } catch (e, s) {
//       return Left(AppException(message: '$e', error: e, stackTrace: s));
//     }
//   }
// }
