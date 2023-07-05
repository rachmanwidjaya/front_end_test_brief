part of ab_chart;

class AbChartColors {
  final Color yAxisTextColor, aLineColor, bLineColor, aPriceColor, bPriceColor;
  AbChartColors({
    this.yAxisTextColor = const Color(0xff60738E),
    this.aLineColor = const Color.fromRGBO(247, 98, 123, 1),
    this.bLineColor = const Color.fromRGBO(70, 166, 221, 1),
    this.aPriceColor = Colors.white,
    this.bPriceColor = Colors.white,
  });
}

class AbChartStyle {
  final double candleLineWidth;
  final int gridRows, gridColumns;
  final double pointWidth, candleWidth, defaultTextSize;
  AbChartStyle({
    this.pointWidth = 3,
    this.candleWidth = 8.5,
    this.candleLineWidth = 10,
    this.gridRows = 5,
    this.gridColumns = 10,
    this.defaultTextSize = 10,
  });
}
