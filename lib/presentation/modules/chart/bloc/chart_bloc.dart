import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_imf_tes/utils/ab_chart/ab_chart.dart';

import '../../../../domain/repository/chart_repository.dart';

abstract class ChartState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChartInitialState extends ChartState {}

class ChartLoadingState extends ChartState {}

class ChartFailedState extends ChartState {
  final String message;
  ChartFailedState({required this.message});
  @override
  List<Object> get props => [message];
}

class ChartSuccsesState extends ChartState {
  final List<AbEntity> data;
  ChartSuccsesState({
    this.data = const [],
  });
  @override
  List<Object> get props => [data];
}

class ChartBloc extends Cubit<ChartState> {
  final ChartRepository repository;
  ChartBloc({
    required this.repository,
  }) : super(ChartInitialState());
  Future<void> load(String symbol, {void Function()? onReady}) async {
    emit(ChartLoadingState());
    await repository.load().then(
          (value) =>
              value.fold((l) => emit(ChartFailedState(message: '$l')), (r) {
            emit(
              ChartSuccsesState(data: r),
            );
            onReady != null ? onReady() : {};
          }),
        );
  }

  manageStream(String event) {
    try {
      List<AbEntity> data =
          List.from((state as ChartSuccsesState).data.take(500));
      if (data.length >= 500) {
        data.removeAt(0);
      }

      data.add(AbModel.fromJson(jsonDecode(event)));

      emit(
        ChartSuccsesState(data: List<AbEntity>.from(data)),
      );
    } catch (e, s) {
      log('$e', error: e, stackTrace: s);
    }
  }
}
