import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toCurrency() => NumberFormat.currency(
        decimalDigits: truncateToDouble() == this ? 0 : 2,
        symbol: '',
      ).format(this);
}
