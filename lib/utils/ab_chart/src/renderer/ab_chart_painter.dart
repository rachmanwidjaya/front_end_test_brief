part of ab_chart;

class _AbChartPainter extends _BaseAbChartPainter {
  late _BaseAbChartRenderer mMainRenderer;
  final double lineWidth;
  final AbChartColors chartColors;
  final int? fractionDigits;

  _AbChartPainter({
    AbChartColors? chartColors,
    super.chartStyle,
    required List<_AbSummary> datas,
    required TextStyle textStyle,
    required super.padding,
    this.fractionDigits,
    this.lineWidth = 1,
  })  : chartColors = chartColors ?? AbChartColors(),
        super(
          datas: datas,
          scaleX: 1,
          scrollX: 0,
        );
  static const int _dashWidth = 10;
  static const int _dashSpace = 0;
  static const int _space = (_dashSpace + _dashWidth);
  static const double priceMArgin = 2;
  static Paint realTimePaint = Paint();

  @override
  void initChartRenderer() {
    mMainRenderer = _AbChartRenderer(
      fractionDigits: fractionDigits,
      padding: padding,
      chartColors: chartColors,
      chartStyle: chartStyle,
      mainRect: mMainRect,
      maxValue: mMainMaxValue,
      minValue: mMainMinValue,
      scaleX: scaleX,
      lineWidth: lineWidth,
      aColor: chartColors.aLineColor,
      bColor: chartColors.bLineColor,
    );
  }

  @override
  void drawChart(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(mTranslateX * scaleX, 0.0);
    canvas.scale(scaleX, 1.0);
    for (int i = mStartIndex; i <= mStopIndex; i++) {
      _AbSummary curPoint = datas[i];
      _AbSummary lastPoint = i == 0 ? curPoint : datas[i - 1];
      double curX = getX(i);
      double lastX = i == 0 ? curX : getX(i - 1);
      mMainRenderer.drawChart(lastPoint, curPoint, lastX, curX, size, canvas);
    }
    canvas.restore();
  }

  @override
  void drawRightText(canvas) {
    mMainRenderer.drawRightText(
      canvas,
      getTextStyle(chartColors.yAxisTextColor),
      chartStyle.gridRows,
    );
  }

  void _drawPrice(
    Canvas canvas,
    Size size, {
    required Color backgroundColor,
    required Color textColor,
    required double point,
  }) {
    double startX = 0;
    final double max = (mTranslateX.abs() +
            mMarginRight -
            getMinTranslateX().abs() +
            mPointWidth) *
        scaleX;
    final double x = mWidth - max;
    final double y = mMainRenderer.getY(point);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: _Format().price(
            point,
            fractionDigits: fractionDigits,
          ),
          style: getTextStyle(textColor)),
      textDirection: TextDirection.ltr,
    )..layout();

    while (startX < max) {
      canvas.drawLine(
        Offset(x + startX, y),
        Offset(x + startX + _dashWidth, y),
        realTimePaint
          ..color = backgroundColor
          ..strokeWidth = lineWidth,
      );
      startX += _space;
    }
    double aLeft = mWidth - textPainter.width;
    double aTop = y - textPainter.height / 2;
    canvas.drawRect(
      Rect.fromLTRB(
        aLeft - priceMArgin - padding.right,
        aTop - priceMArgin,
        aLeft + textPainter.width + priceMArgin,
        aTop + textPainter.height + priceMArgin,
      ),
      realTimePaint
        ..color = backgroundColor
        ..strokeWidth = lineWidth,
    );
    textPainter.paint(canvas, Offset(aLeft - padding.right, aTop));
  }

  @override
  drawRealTimePrice(canvas, size) {
    _drawPrice(
      canvas,
      size,
      backgroundColor: chartColors.aLineColor,
      textColor: chartColors.aPriceColor,
      point: datas.last.a,
    );
    _drawPrice(
      canvas,
      size,
      backgroundColor: chartColors.bLineColor,
      textColor: chartColors.bPriceColor,
      point: datas.last.b,
    );
  }
}
