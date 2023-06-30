// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/repository_impl/local_config.dart';
// import '../../domain/entities/user_entity.dart';
// import '../../domain/repository/auth_repository.dart';

// abstract class AuthState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class AuthLoadingState extends AuthState {}

// class AuthSigninState extends AuthState {}

// class AuthIsAuthorizedState extends AuthState {
//   final UserEntity user;
//   AuthIsAuthorizedState({required this.user});
//   @override
//   List<Object?> get props => [user];
// }

// class AuthUnAuthorizedState extends AuthState {}

// class AuthFailedLoginState extends AuthState {
//   final String message;
//   AuthFailedLoginState({required this.message});
//   @override
//   List<Object?> get props => [message];
// }

// class AuthBloc extends Cubit<AuthState> {
//   final AuthRepository repository;
//   AuthBloc({required this.repository}) : super(AuthLoadingState());

//   Future<void> initAuth() async {
//     await repository.validate().then(
//       (value) {
//         value.fold(
//           (l) {},
//           (r) {
//             emit(r != null
//                 ? AuthIsAuthorizedState(user: r)
//                 : AuthUnAuthorizedState());
//           },
//         );
//       },
//     );
//   }

//   Future<void> signIn({void Function(String message)? onError}) async {
//     emit(AuthSigninState());
//     await repository.signIn().then(
//       (value) {
//         value.fold(
//           (l) {
//             onError != null ? onError('$l') : {};
//             emit(AuthFailedLoginState(message: '$l'));
//           },
//           (r) {
//             LocalConfig.instance.token = r.accessToken;
//             emit(AuthIsAuthorizedState(user: r));
//           },
//         );
//       },
//     );
//   }

//   Future<void> signOut({void Function(String message)? onError}) async {
//     await repository.signOut().then(
//       (value) {
//         value.fold(
//           (l) {
//             onError != null ? onError('$l') : {};
//           },
//           (r) {
//             LocalConfig.instance.token = null;
//             emit(AuthUnAuthorizedState());
//           },
//         );
//       },
//     );
//   }
// }
