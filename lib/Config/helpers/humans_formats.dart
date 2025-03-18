import 'package:intl/intl.dart';

class HumansFormats {
  static String number(double number) {
    int numberRevised = int.parse(number.toString().replaceAll('.', ''));
    final formatedNumeber = NumberFormat.compactCurrency(
            decimalDigits: 0, symbol: "", locale: "en_US")
        .format(numberRevised);

    return formatedNumeber;
  }
}
