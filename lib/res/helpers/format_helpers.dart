import 'package:intl/intl.dart';

class FormatHelpers {
  static String formatterNumber(double number) {
    return NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2)
        .format(number);
  }

  static String? emptyToNull(String text) =>
      text.trim().isEmpty ? null : text.trim();
}
