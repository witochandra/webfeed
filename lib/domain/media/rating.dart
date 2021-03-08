import 'package:xml/xml.dart';

class Rating {
  final String? scheme;
  final String? value;

  Rating({
    this.scheme,
    this.value,
  });

  static parse(XmlElement? element) {
    if (element == null) return null;
    return Rating(
      scheme: element.getAttribute('scheme'),
      value: element.text,
    );
  }
}
