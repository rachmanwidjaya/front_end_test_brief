import 'package:dartz/dartz.dart';

import '../../utils/ab_chart/ab_chart.dart';

abstract class ChartRepository {
  Future<Either<Exception, List<AbEntity>>> load();
}
