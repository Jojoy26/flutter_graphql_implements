import 'package:flutter_gameplay/src/utils/format_number.dart';
import 'package:flutter_gameplay/src/utils/get_weekday.dart';

String formatDate(String dateMilliseconds) {
  int intDateMilliseconds = int.parse(dateMilliseconds);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(intDateMilliseconds);
  return "${getWeekday(date.weekday)} ${formatNumber(date.day)}/${formatNumber(date.month)} às ${formatNumber(date.hour)}:${formatNumber(date.minute)}h";
}