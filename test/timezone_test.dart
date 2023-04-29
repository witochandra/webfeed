import 'package:test/test.dart';
import 'package:webfeed/util/timezone.dart';

main() {

  group('Abbreviated timezones', () {

    test('parse GMT timezone', () {
      final offset = getTimeZoneOffset('GMT');
      expect(offset, 0);
    });

    test('parse EET timezone', () {
      final offset = getTimeZoneOffset('EET');
      expect(offset, 2 * 60);
    });

    test('parse EST timezone', () {
      final offset = getTimeZoneOffset('EST');
      expect(offset, -5 * 60);
    });

  });


  group('Offset timezones', () {
    
    test('parse 00:00 timezone', () {
      final offset = getTimeZoneOffset('00:00');
      expect(offset, 0);
    });

    test('parse 0000 timezone', () {
      final offset = getTimeZoneOffset('0000');
      expect(offset, 0);
    });

    test('parse +01:00 timezone', () {
      final offset = getTimeZoneOffset('+01:00');
      expect(offset, 60);
    });

    test('parse 01:00 timezone', () {
      final offset = getTimeZoneOffset('01:00');
      expect(offset, 60);
    });

    test('parse 0100 timezone', () {
      final offset = getTimeZoneOffset('0100');
      expect(offset, 60);
    });

    test('parse -01:00 timezone', () {
      final offset = getTimeZoneOffset('-01:00');
      expect(offset, -60);
    });

    test('parse -0100 timezone', () {
      final offset = getTimeZoneOffset('-0100');
      expect(offset, -60);
    });

    test('parse -03:30 timezone', () {
      final offset = getTimeZoneOffset('-03:30');
      expect(offset, -3 * 60 - 30);
    });

  });

}
