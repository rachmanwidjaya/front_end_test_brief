part of ab_chart;

/// ## ab_chart
/// ### for: Forex Imf Tes UI
/// ## ======================
/// Librarry ini dibuat oleh:
/// #### @rachmanwidjaya
///
/// Dibuat khusus untuk Tes UI ke Forex IMF
///
/// Tidak diperkenankan menggunakan Library ini tanpa ijin
///
/// Referensi: https://pub.dev/packages/technixo_k_chart_v2
///

class AbChartWidget extends StatelessWidget {
  final List<AbEntity> datas;
  final List<Color>? backgoundColor;
  final AbChartColors? chartColors;
  final AbChartStyle? chartStyle;
  final TextStyle textStyle;
  final double lineWidth;
  final EdgeInsets padding;
  final int? fractionDigits;
  const AbChartWidget({
    required this.datas,
    this.chartColors,
    this.chartStyle,
    this.padding = EdgeInsets.zero,
    super.key,
    this.textStyle = const TextStyle(),
    this.backgoundColor,
    this.lineWidth = 1,
    required this.fractionDigits,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: _AbChartPainter(
        fractionDigits: fractionDigits,
        chartStyle: chartStyle,
        datas: datas,
        textStyle: textStyle,
        lineWidth: lineWidth,
        padding: padding,
        chartColors: chartColors,
      ),
    );
  }
}
