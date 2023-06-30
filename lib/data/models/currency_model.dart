import '../../domain/entities/currency_entity.dart';
import 'candle_model.dart';

class CurrencyModel extends CurrencyEntity {
  CurrencyModel.fromJson(Map<String, dynamic> json)
      : super(
          symbol: json['symbol'],
          timeFrame: json['timeFrame'],
          candles: CandleModel.parseEntrie(json['candle']),
        );

  static List<CurrencyEntity> parseEntrie(List<dynamic> json) =>
      List<CurrencyEntity>.from(json.map((e) => CurrencyModel.fromJson(e)));
}
