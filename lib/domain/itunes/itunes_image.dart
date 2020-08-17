import 'package:xml/xml.dart';

class ItunesImage {
  final String href;

  ItunesImage({this.href});

  factory ItunesImage.parse(XmlElement element) {
    if (element == null) return null;
    return ItunesImage(
      href: element.getAttribute('href')?.trim(),
    );
  }
}
