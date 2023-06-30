import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/exceptions/parser_exeption.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/repository/api_repository.dart';
import '../../domain/repository/home_repositry.dart';
import '../models/currency_model.dart';

class HomeRepositoryImpl extends HomeRepository {
  final ApiRepository apiRepository;
  HomeRepositoryImpl({required this.apiRepository});
  @override
  Future<Either<Exception, List<CurrencyEntity>>> load() async {
    try {
      return await apiRepository
          .request('https://cunguk1.my.id/imf_x.json')
          .then((value) => Right(CurrencyModel.parseEntrie(
                jsonDecode(value),
              )));
    } on NoSuchMethodError catch (e, s) {
      return Left(ParserException(
        errorCode: '003',
        error: e,
        stackTrace: s,
      ));
    } catch (e, s) {
      return Left(AppException(
        message: 'Get data failed',
        errorCode: '004',
        error: e,
        stackTrace: s,
      ));
    }
  }
}
