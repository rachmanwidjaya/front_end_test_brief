import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/entities/currency_entity.dart';
import '../../../../../../domain/repository/home_repositry.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFailedState extends HomeState {
  final String message;
  HomeFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class HomeSucsessState extends HomeState {
  final List<CurrencyEntity> data;
  HomeSucsessState({required this.data});

  @override
  List<Object> get props => [data];
}

class HomeBloc extends Cubit<HomeState> {
  final HomeRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitialState());

  Future<void> load() async {
    emit(HomeLoadingState());
    await repository.load().then(
      (value) {
        value.fold(
          (l) {
            emit(HomeFailedState(message: '$l'));
          },
          (r) {
            emit(HomeSucsessState(data: r));
          },
        );
      },
    );
  }
}
