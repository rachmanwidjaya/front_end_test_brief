import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/chart_candle_entity.dart';
import '../../domain/repository/api_repository.dart';
import '../../domain/repository/chart_repository.dart';
import '../models/chart_candle_model.dart';

class ChartRepositoryImpl extends ChartRepository {
  final ApiRepository apiRepository;
  ChartRepositoryImpl({
    required this.apiRepository,
  });
  @override
  Future<Either<Exception, List<ChartCandleEntity>>> load() async {
    try {
      return await apiRepository
          .request('https://cunguk1.my.id/imf_y.json')
          .then((value) =>
              Right(ChartCandleModel.parseEntrie(jsonDecode(value))));
    } catch (e, s) {
      return Left(AppException(
        errorCode: '099',
        error: e,
        stackTrace: s,
      ));
    }
  }
}
