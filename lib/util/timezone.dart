const timeZoneAbbreviations = {
  'EET': 2 *  60,
  'CET': 1 * 60,
  'GMT': 0,
  'AST': -4 * 60,
  'EST': -5 * 60,
  'EDT': -4 * 60,
  'CST': -6 * 60,
  'CDT': -5 * 60,
  'MST': -7 * 60,
  'MDT': -6 * 60,
  'PST': -8 * 60,
  'PDT': -7 * 60,
};

/// Test this regexp online at https://regex101.com/r/mem3xt/1
final offsetRegExp = RegExp(r'^(?<sign>[\+\-]?)(?<hours>\d{2})\:?(?<minutes>\d{2})$');


/// Parse a potential timezone string and return the
/// time offset in minutes
int? getTimeZoneOffset(String timezone) {
  // check if timezone is one of the known abbreviations
  var offset = timeZoneAbbreviations[timezone.toUpperCase()];
  if (offset != null) return offset;
  // check if the timezone is of type offset
  final match = offsetRegExp.firstMatch(timezone);
  if (match != null) {
    final sign = match.namedGroup('sign') == '-' ? -1 : 1;
    // we know <hours> and <minutes> are not null because the RexExp matched
    final hours = int.parse(match.namedGroup('hours')!);
    final minutes = int.parse(match.namedGroup('minutes')!);
    return sign * (60 * hours + minutes);
  }

  return null;
}