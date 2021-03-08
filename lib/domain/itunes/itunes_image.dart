import 'package:xml/xml.dart';

class ItunesImage {
  final String? href;

  ItunesImage({this.href});

  static parse(XmlElement? element) {
    ItunesImage? result;
    if (element == null) return null;
    result = ItunesImage(
      href: element.getAttribute('href')?.trim(),
    );

    return result;
  }
}
