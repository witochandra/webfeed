import 'package:intl/intl.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';

DateTime parseDateTime(String dateString) {
  if (dateString == null) return null;
  return _parseRfc822DateTime(dateString.trim()) ?? _parseIso8601DateTime(dateString.trim());
}

DateTime _parseRfc822DateTime(String dateString) {
  try {
    final length = dateString?.length?.clamp(0, rfc822DatePattern.length);
    final trimmedPattern = rfc822DatePattern.substring(0, length); //Some feeds use a shortened RFC 822 date, e.g. 'Tue, 04 Aug 2020'
    final format = DateFormat(trimmedPattern, 'en_US');
    return format.parse(dateString);
  } on FormatException {
    return null;
  }
}

DateTime _parseIso8601DateTime(String dateString) {
  try {
    return DateTime.parse(dateString);
  } on FormatException {
    return null;
  }
}
