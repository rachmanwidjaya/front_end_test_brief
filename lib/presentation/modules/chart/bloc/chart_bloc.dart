import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/chart_candle_model.dart';
import '../../../../domain/entities/chart_candle_entity.dart';
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
  final List<ChartCandleEntity> data;
  final double minValue;
  final double maxValue;
  ChartSuccsesState({
    this.data = const [],
    required this.minValue,
    required this.maxValue,
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
              ChartSuccsesState(
                data: r.reversed.toList(),
                minValue: r
                    .map((entity) => entity.a < entity.b ? entity.a : entity.b)
                    .reduce((current, next) => current < next ? current : next),
                maxValue: r
                    .map((entity) => entity.a > entity.b ? entity.a : entity.b)
                    .reduce((current, next) => current > next ? current : next),
              ),
            );
            onReady != null ? onReady() : {};
          }),
        );
  }

  manageStream(String event) {
    try {
      List<ChartCandleEntity> data =
          List.from((state as ChartSuccsesState).data.take(500));
      if (data.length >= 500) {
        data.removeAt(0);
      }

      data.add(ChartCandleModel.fromJson(jsonDecode(event)));

      emit(
        ChartSuccsesState(
          data: List<ChartCandleEntity>.from(data),
          minValue: data
              .map((entity) => entity.a < entity.b ? entity.a : entity.b)
              .reduce((current, next) => current < next ? current : next),
          maxValue: data
              .map((entity) => entity.a > entity.b ? entity.a : entity.b)
              .reduce((current, next) => current > next ? current : next),
        ),
      );
    } catch (e, s) {
      log('$e', error: e, stackTrace: s);
    }
  }
}
