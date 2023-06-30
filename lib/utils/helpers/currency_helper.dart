class CurrencyHelper {
  String calculatePercentage(double value1, double value2) {
    double percentageChange = ((value2 - value1) / value1) * 100;
    return "${(!percentageChange.isNegative) ? '+' : ''}${percentageChange.toStringAsFixed(2)}";
  }
}
