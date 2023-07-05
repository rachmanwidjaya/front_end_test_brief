part of ab_chart;

class _AbChartRenderer extends _BaseAbChartRenderer<_AbSummary> {
  final Rect mainRect;
  final double lineWidth;
  final Color aColor;
  final Color bColor;
  final EdgeInsets padding;
  _AbChartRenderer({
    required this.mainRect,
    required double maxValue,
    required double minValue,
    required double scaleX,
    required super.chartColors,
    required super.chartStyle,
    required this.aColor,
    required this.bColor,
    super.fractionDigits,
    required this.padding,
    this.lineWidth = 1,
  }) : super(
          chartRect: mainRect,
          maxValue: maxValue,
          minValue: minValue,
          scaleX: scaleX,
        );

  @override
  void drawChart(_AbSummary lastPoint, _AbSummary curPoint, double lastX,
      double curX, Size size, Canvas canvas) {
    final Path path = Path();
    final Paint paint = Paint();
    path.moveTo(lastX, getY(lastPoint.a));
    path.cubicTo((lastX + curX) / 2, getY(lastPoint.a), (lastX + curX) / 2,
        getY(curPoint.a), curX, getY(curPoint.a));

    canvas.drawPath(
      path,
      paint
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = aColor
        ..strokeWidth = ((lineWidth) / scaleX).clamp(0.3, lineWidth),
    );
    path.reset();
    path.moveTo(lastX, getY(lastPoint.b));
    path.cubicTo((lastX + curX) / 2, getY(lastPoint.b), (lastX + curX) / 2,
        getY(curPoint.b), curX, getY(curPoint.b));

    canvas.drawPath(
      path,
      paint
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = bColor
        ..strokeWidth = (lineWidth / scaleX).clamp(0.3, lineWidth),
    );
    path.reset();
  }

  @override
  void drawRightText(canvas, textStyle, int xGridRow) {
    final gridRows = xGridRow - 1;
    double rowSpace = (chartRect.height - 5) / gridRows;
    for (int i = 0; i <= gridRows; ++i) {
      double position = 0;
      if (i == 0) {
        position = (gridRows - i) * rowSpace;
      } else if (i == gridRows) {
        position = (gridRows - i) * rowSpace;
      } else {
        position = (gridRows - i) * rowSpace;
      }
      final double value = position / scaleY + minValue;
      TextSpan span = TextSpan(
          text: _Format().price(
            value,
            fractionDigits: fractionDigits,
          ),
          style: textStyle);
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      double y;
      if (i == 0 || i == gridRows) {
        y = getY(value) - tp.height / 2;
      } else {
        y = getY(value) - tp.height;
      }
      tp.paint(canvas, Offset(chartRect.width - tp.width - padding.right, y));
    }
  }
}
