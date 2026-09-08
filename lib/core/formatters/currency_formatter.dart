import 'package:intl/intl.dart';

String formatCurrency(int amountInCents, String currencyCode) {
  return NumberFormat.currency(
    locale: 'en_IE',
    symbol: currencyCode == 'EUR' ? '€ ' : '$currencyCode ',
    decimalDigits: 2,
  ).format(amountInCents / 100);
}
