import 'package:dartz/dartz.dart';

import '../entities/currency_entity.dart';

abstract class HomeRepository {
  Future<Either<Exception, List<CurrencyEntity>>> load();
}
