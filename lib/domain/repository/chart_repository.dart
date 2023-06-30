import 'package:dartz/dartz.dart';

import '../entities/chart_candle_entity.dart';

abstract class ChartRepository {
  Future<Either<Exception, List<ChartCandleEntity>>> load();
}
