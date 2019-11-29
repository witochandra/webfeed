import 'package:xml/xml.dart';

class License {
  final String type;
  final Uri href;
  final String value;

  License({
    this.type,
    this.href,
    this.value,
  });

  factory License.parse(XmlElement element) {
    if (element == null) return null;
    var href = element.getAttribute("href");
    return License(
      type: element.getAttribute("type"),
      href: href == null ? null : Uri.parse(href),
      value: element.text,
    );
  }
}
