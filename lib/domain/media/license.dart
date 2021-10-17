import 'package:xml/xml.dart';

class License {
  final String? type;
  final String? href;
  final String? value;

  License({
    this.type,
    this.href,
    this.value,
  });

  factory License.parse(XmlElement element) {
    return License(
      type: element.getAttribute('type'),
      href: element.getAttribute('href'),
      value: element.text,
    );
  }
}
