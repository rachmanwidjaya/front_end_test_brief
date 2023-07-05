part of ab_chart;

abstract class _BaseAbChartPainter extends CustomPainter {
  final List<_AbSummary> datas;
  final double scaleX;
  final double scrollX;
  final EdgeInsets padding;
  late Rect mMainRect;

  final AbChartStyle chartStyle;

  _BaseAbChartPainter({
    AbChartStyle? chartStyle,
    required this.datas,
    this.scaleX = 1,
    this.scrollX = 0,
    required this.padding,
  }) : chartStyle = chartStyle ?? AbChartStyle() {
    mPointWidth = this.chartStyle.pointWidth;
    mItemCount = datas.length;
  }
  late double mDisplayHeight, mWidth;

  int mStartIndex = 0, mStopIndex = 0;
  double mMainMaxValue = -double.maxFinite, mMainMinValue = double.maxFinite;
  double mTranslateX = -double.maxFinite;
  int mMainMaxIndex = 0, mMainMinIndex = 0;
  double mMainHighMaxValue = -double.maxFinite,
      mMainLowMinValue = double.maxFinite;
  int mItemCount = 0;
  double mDataLen = 0.0;
  late double mPointWidth;
  double mMarginRight = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
    mDisplayHeight = size.height - padding.top - padding.bottom - 5;
    mWidth = size.width;
    // mMarginRight = (mWidth / chartStyle.gridColumns - mPointWidth) / scaleX;
    mMarginRight = 100;
    initRect(size);
    calculateValue();
    initChartRenderer();
    canvas.save();
    canvas.scale(scaleX, 1);
    if (datas.isNotEmpty) {
      drawChart(canvas, size);
      drawRightText(canvas);
      drawRealTimePrice(canvas, size);
    }
    canvas.restore();
  }

  void initChartRenderer();

  void drawChart(Canvas canvas, Size size);
  void drawRightText(canvas);
  drawRealTimePrice(canvas, size);

  void initRect(Size size) {
    double mainHeight = mDisplayHeight * 0.6;
    mainHeight = mDisplayHeight;
    mMainRect = Rect.fromLTRB(0, padding.top, mWidth, padding.top + mainHeight);
  }

  calculateValue() {
    if (datas.isEmpty) return;
    setTranslateXFromScrollX(scrollX);
    mStartIndex = indexOfTranslateX(xToTranslateX(0));
    mStopIndex = indexOfTranslateX(xToTranslateX(mWidth));
    for (int i = mStartIndex; i <= mStopIndex; i++) {
      var item = datas[i];
      getMainMaxMinValue(item, i);
    }
  }

  void getMainMaxMinValue(_AbSummary item, int i) {
    mMainMaxValue = max(mMainMaxValue, item.a > item.b ? item.a : item.b);
    mMainMinValue = min(mMainMinValue, item.a < item.b ? item.a : item.b);
  }

  double xToTranslateX(double x) => -mTranslateX + x / scaleX;

  int indexOfTranslateX(double translateX) =>
      _indexOfTranslateX(translateX, 0, mItemCount - 1);
  int _indexOfTranslateX(double translateX, int start, int end) {
    if (end == start || end == -1) {
      return start;
    }
    if (end - start == 1) {
      double startValue = getX(start);
      double endValue = getX(end);
      return (translateX - startValue).abs() < (translateX - endValue).abs()
          ? start
          : end;
    }
    int mid = start + (end - start) ~/ 2;
    double midValue = getX(mid);
    if (translateX < midValue) {
      return _indexOfTranslateX(translateX, start, mid);
    } else if (translateX > midValue) {
      return _indexOfTranslateX(translateX, mid, end);
    } else {
      return mid;
    }
  }

  double getX(int position) => position * mPointWidth + mPointWidth / 2;

  _AbSummary getItem(int position) => datas[position];

  void setTranslateXFromScrollX(double scrollX) =>
      mTranslateX = scrollX + getMinTranslateX();
  double getMinTranslateX() {
    var x = -mDataLen + mWidth / scaleX - mPointWidth / 2;
    x = x >= 0 ? 0.0 : x;
    if (x >= 0) {
      if (mWidth / scaleX - getX(datas.length) < mMarginRight) {
        x -= mMarginRight - mWidth / scaleX + getX(datas.length);
      } else {
        mMarginRight = mWidth / scaleX - getX(datas.length);
      }
    } else if (x < 0) {
      x -= mMarginRight;
    }
    return x >= 0 ? 0.0 : x;
  }

  TextStyle getTextStyle(Color color) =>
      TextStyle(fontSize: chartStyle.defaultTextSize, color: color);

  @override
  bool shouldRepaint(_BaseAbChartPainter oldDelegate) => true;
}
