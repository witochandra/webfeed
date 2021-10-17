import 'package:xml/xml.dart';

enum ItunesType { episodic, serial, unknown }

ItunesType newItunesType(XmlElement element) {
  switch (element.text) {
    case 'episodic':
      return ItunesType.episodic;
    case 'serial':
      return ItunesType.serial;
    default:
      return ItunesType.unknown;
  }
}
