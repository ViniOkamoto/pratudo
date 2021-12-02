import 'package:intl/intl.dart';

class DateHelper {
  static String formatDateToString(DateTime datetime) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String dateFormatted = formatter.format(datetime);

    return dateFormatted;
  }
}
