import 'package:intl/intl.dart';

var rfc822DateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss Z', 'en_US');

DateTime parseDateTime(dateString) {
  if (dateString == null) return null;
  return _parseRfc822DateTime(dateString) ?? _parseIso8601DateTime(dateString);
}

DateTime _parseRfc822DateTime(dateString) {
  try {
    return rfc822DateFormat.parse(dateString);
  } on FormatException {
    return null;
  }
}

DateTime _parseIso8601DateTime(dateString) {
  try {
    return DateTime.parse(dateString);
  } on FormatException {
    return null;
  }
}
