import '../../domain/entities/chart_candle_entity.dart';

class ChartCandleModel extends ChartCandleEntity {
  ChartCandleModel.fromJson(Map<String, dynamic> json)
      : super(
          s: json['s'] ?? '',
          a: json['a'] ?? 0.toDouble(),
          b: json['b'].toDouble(),
          dc: json['dc'],
          dd: json['dd'],
          ppms: json['ppms'],
          t: json['t'],
        );
  static List<ChartCandleEntity> parseEntrie(List<dynamic> json) =>
      List<ChartCandleEntity>.from(
          json.map((e) => ChartCandleModel.fromJson(e)));
}
