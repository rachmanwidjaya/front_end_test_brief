import '../../domain/entities/candle_entity.dart';

class CandleModel extends CandleEntity {
  CandleModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          open: json['open'].toDouble(),
          low: json['low'].toDouble(),
          high: json['high'].toDouble(),
          close: json['close'].toDouble(),
          volume: json['volume'].toDouble(),
          time: DateTime.parse(json['time']),
        );

  static List<CandleEntity> parseEntrie(List<dynamic> json) =>
      List<CandleEntity>.from(json.map((e) => CandleModel.fromJson(e)));
}
