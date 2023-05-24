import 'package:intl/intl.dart';

String getCurrentFormattedDate() {
  DateTime now = DateTime.now();
  return DateFormat.MMMEd().format(now);
}
