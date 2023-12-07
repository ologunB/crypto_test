import 'package:intl/intl.dart';

extension CustomStringExtension on String {
  toAmount() {
    return NumberFormat("#,##0.00", "en_US")
        .format(double.tryParse(this) ?? 0.00);
  }

  get png => 'assets/images/$this.png';
}
