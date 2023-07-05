part of ab_chart;

abstract class _BaseAbChartRenderer<T> {
  double maxValue, minValue;
  late double scaleY, scaleX;
  Rect chartRect;
  final AbChartColors chartColors;
  final AbChartStyle chartStyle;
  final int? fractionDigits;
  _BaseAbChartRenderer({
    required this.chartStyle,
    required this.chartColors,
    required this.chartRect,
    required this.maxValue,
    required this.minValue,
    required this.scaleX,
    this.fractionDigits,
  }) {
    if (maxValue == minValue) {
      maxValue += 0.5;
      minValue -= 0.5;
    }
    scaleY = chartRect.height / (maxValue - minValue);
  }

  double getY(double y) => (maxValue - y) * scaleY + chartRect.top;

  void drawRightText(canvas, textStyle, int gridRows);

  void drawChart(T lastPoint, T curPoint, double lastX, double curX, Size size,
      Canvas canvas);

  TextStyle getTextStyle(Color color) =>
      TextStyle(fontSize: chartStyle.defaultTextSize, color: color);
}
