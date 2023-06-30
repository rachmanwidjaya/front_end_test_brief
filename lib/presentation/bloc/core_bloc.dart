import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/remote_config_repository.dart';
import '../../config/enum/app_state.dart';
import '../../domain/entities/remote_config_entity.dart';

abstract class CoreState extends Equatable {
  final AppState appState;
  const CoreState({this.appState = AppState.loading});
  @override
  List<Object?> get props => [appState];
}

class CoreLoadingState extends CoreState {}

class CoreFailedState extends CoreState {
  final Exception e;

  const CoreFailedState(this.e, {super.appState = AppState.failed});
  @override
  List<Object?> get props => [e, appState];
}

class CoreReadyState extends CoreState {
  final RemoteConfigEntity remoteConfig;
  const CoreReadyState({required this.remoteConfig, super.appState});
  @override
  List<Object?> get props => [remoteConfig];
}

class CoreBloc extends Cubit<CoreState> {
  final RemoteConfigRepository remoteConfig;
  CoreBloc({
    required this.remoteConfig,
  }) : super(CoreLoadingState());

  Future<void> init() async {
    emit(CoreLoadingState());
    await remoteConfig.load().then(
      (value) {
        value.fold(
          (l) {
            emit(CoreFailedState(l));
          },
          (r) {
            emit(CoreReadyState(remoteConfig: r, appState: r.toAppState));
          },
        );
      },
    );
  }
}
