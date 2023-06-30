import 'dart:convert';

import 'candle_entity.dart';

class CurrencyEntity {
  final String symbol;
  final String timeFrame;
  final List<CandleEntity> candles;
  CurrencyEntity({
    required this.symbol,
    required this.timeFrame,
    this.candles = const [],
  });
  Map<String, dynamic> toMap() => {
        "symbol": symbol,
        "timeFrame": timeFrame,
        "candles": List.from(candles.map((e) => e.toMap()))
      };
  @override
  String toString() => jsonEncode(toMap());
}
