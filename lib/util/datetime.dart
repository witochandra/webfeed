import 'package:intl/intl.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';
const customDatePattern = 'EEE dd MMM yyyy, HH:mm:ss Z';

DateTime? parseDateTime(dateString) {
  if (dateString == null) return null;
  return _parsePatternDateTime(dateString, rfc822DatePattern) ??
      _parsePatternDateTime(dateString, customDatePattern) ??
      _parseIso8601DateTime(dateString);
}

DateTime? _parseIso8601DateTime(dateString) {
  try {
    return DateTime.parse(dateString);
  } on FormatException {
    return null;
  }
}

DateTime? _parsePatternDateTime(String dateString, String pattern) {
  try {
    final num? length = dateString.length.clamp(0, pattern.length);
    final trimmedPattern = pattern.substring(
        0,
        length
            as int?); //Some feeds use a shortened RFC 822 date, e.g. 'Tue, 04 Aug 2020'
    final format = DateFormat(trimmedPattern, 'en_US');
    return format.parse(dateString);
  } on FormatException {
    return null;
  }
}
