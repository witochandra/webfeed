import 'package:xml/xml.dart';

class RssCategory {
  String domain;
  String value;

  RssCategory(this.domain, this.value);

  factory RssCategory.parse(XmlElement node) {
    var domain = node.getAttribute("domain");
    var value = node.text;

    return new RssCategory(domain, value);
  }

  @override
  String toString() {
    return '''
      domain: $domain
      value: $value
    ''';
  }
}
