import 'dart:convert';

class CandleEntity {
  final String id;
  final double open;
  final double low;
  final double high;
  final double close;
  final double volume;
  final DateTime time;
  CandleEntity({
    required this.id,
    required this.open,
    required this.low,
    required this.high,
    required this.close,
    required this.volume,
    required this.time,
  });
  Map<String, dynamic> toMap() => {
        "id": id,
        "open": open,
        "low": low,
        "high": high,
        "close": close,
        "volume": volume,
        "time": time.toString(),
      };
  @override
  String toString() => jsonEncode(toMap());
}
