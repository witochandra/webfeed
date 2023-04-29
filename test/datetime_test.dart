import 'package:test/test.dart';
import 'package:webfeed/util/datetime.dart';

void main() {

  group('RFC 822 date time', () {

    test('parse GMT date time', () {
      final dateString = 'Sat, 29 Apr 2023 12:00:00 GMT';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 29, 12, 0, 0));
    });


    test('parse EST date time', () {
      final dateString = 'Sat, 29 Apr 2023 21:22:23 EST';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 30, 2, 22, 23));
    });


    test('parse +0000 offset date time', () {
      final dateString = 'Fri, 28 Apr 2023 23:00:57 +0000';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 28, 23, 0, 57));
    });


    test('parse -0000 offset date time', () {
      // yes, really, I saw this format here: https://feeds.megaphone.fm/bitcoinaudible
      final dateString = 'Thu, 27 Apr 2023 19:17:00 -0000';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 27, 19, 17, 0));
    });

    test('parse +0100 offset date time', () {
      final dateString = 'Fri, 28 Apr 2023 19:02:17 +0100';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 28, 18, 2, 17));
    });


    test('parse 02:00 offset date time', () {
      final dateString = 'Thu, 27 Apr 2023 14:30:00 02:00';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 27, 12, 30, 0));
    });


    test('parse -0500 offset date time', () {
      final dateString = 'Thu, 27 Apr 2023 14:30:00 -0500';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 27, 19, 30, 0));
    });

  });



  group('ISO 8601 date time', () {

    test('parse +00:00 offset date time', () {
      final dateString = '2023-04-24T05:02:37+00:00';
      final result = parseDateTime(dateString);
      expect(result, isNotNull);
      expect(result!.isUtc, true);
      expect(result, DateTime.utc(2023, 4, 24, 5, 2, 37));
    });

  });




}