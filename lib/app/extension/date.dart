import 'package:intl/intl.dart';

extension CustomDate on DateTime {
  get myDate {
    String monthName = DateFormat.MMMM().format(this);
    return '$day $monthName, $year'.toString();
  }
}
