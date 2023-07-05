part of ab_chart;

class _Format {
  String price(double n, {int? fractionDigits}) =>
      n.toStringAsFixed(fractionDigits ??
          ('$n'.split('.').isNotEmpty ? '$n'.split('.').last.length : 0));
}
