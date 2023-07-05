import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:forex_imf_tes/utils/ab_chart/ab_chart.dart';

import '../../core/exceptions/app_exception.dart';
import '../../domain/repository/api_repository.dart';
import '../../domain/repository/chart_repository.dart';

class ChartRepositoryImpl extends ChartRepository {
  final ApiRepository apiRepository;
  ChartRepositoryImpl({
    required this.apiRepository,
  });
  @override
  Future<Either<Exception, List<AbEntity>>> load() async {
    try {
      return await apiRepository
          .request('https://cunguk1.my.id/imf_y.json')
          .then((value) => Right(AbModel.parseEntrie(jsonDecode(value))));
    } catch (e, s) {
      return Left(AppException(
        errorCode: '099',
        error: e,
        stackTrace: s,
      ));
    }
  }
}
