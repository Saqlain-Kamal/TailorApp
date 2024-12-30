extension CustomDate on DateTime {
  get myDate {
    return '$month $day, $year'.toString();
  }
}
