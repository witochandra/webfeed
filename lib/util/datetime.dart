import 'package:intl/intl.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';
const rfc822DateWithoutSecondsPattern = 'EEE, dd MMM yyyy HH:mm Z';
const rfc822DateOnlyPattern = 'EEE, dd MMM yyyy';

DateTime parseDateTime(dateString) {
  if (dateString == null) return null;
  return _parseRfc822DateTime(dateString) ?? _parseIso8601DateTime(dateString);
}

DateTime _parseRfc822DateTime(String dateString) {
  try {
    var pattern = rfc822DateOnlyPattern;
    if (dateString.contains(RegExp(r'(0?[1-9]|1[0-2]):[0-5][0-9]:[0-5][0-9]'))) {
      pattern = rfc822DatePattern;
    } else if (dateString.contains(RegExp(r'(0?[1-9]|1[0-2]):[0-5][0-9]'))) {
      pattern = rfc822DateWithoutSecondsPattern;
    }

    final format = DateFormat(pattern, 'en_US');
    return format.parse(dateString);
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
