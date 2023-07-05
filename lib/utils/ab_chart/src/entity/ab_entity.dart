part of ab_chart;

class _AbSummary {
  final double a;
  final double b;
  _AbSummary({
    required this.a,
    required this.b,
  });
}

class AbEntity extends _AbSummary {
  final String s;
  final String dc;
  final String dd;
  final bool ppms;
  final DateTime t;
  AbEntity({
    required super.a,
    required super.b,
    required this.s,
    required this.dc,
    required this.dd,
    required this.ppms,
    required this.t,
  });
}

class AbModel extends AbEntity {
  AbModel.fromJson(Map<String, dynamic> j)
      : super(
          a: double.parse(j['a']?.toString() ?? '0'),
          b: double.parse(j['b']?.toString() ?? '0'),
          s: j['s'] ?? '',
          dc: j['dc'] ?? '',
          dd: j['dd'] ?? '',
          ppms: j['ppms'] ?? false,
          t: DateTime.fromMillisecondsSinceEpoch(j['t']),
        );
  AbModel.fromBinanceApi(List<dynamic> j)
      : super(
          a: double.parse(j[2]?.toString() ?? '0'),
          b: double.parse(j[3]?.toString() ?? '0'),
          s: '',
          dc: j[1],
          dd: j[4],
          ppms: false,
          t: DateTime.fromMillisecondsSinceEpoch(j[0]),
        );
  static List<AbEntity> parseXxxEntrie(List<dynamic> j) =>
      List.from(j.map((e) => AbModel.fromBinanceApi(e)));

  static List<AbEntity> parseEntrie(List<dynamic> j) =>
      List.from(j.map((e) => AbModel.fromJson(e)));
}
