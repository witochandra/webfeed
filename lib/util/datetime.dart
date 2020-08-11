import 'package:intl/intl.dart';

var rfc822DateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en_US');

DateTime parseDateTime(dateString) {
  if (dateString == null) return null;
  try {
    return rfc822DateFormat.parse(dateString);
  } on FormatException {
    return null;
  }
}
