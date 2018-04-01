import 'package:xml/xml/nodes/element.dart';

class RssSource {
  String url;
  String value;

  RssSource(this.url, this.value);

  factory RssSource.parse(XmlElement node) {
    var url = node.getAttribute("url");
    var value = node.text;

    return new RssSource(url, value);
  }

  @override
  String toString() {
    return '''
      url: $url
      value: $value
    ''';
  }
}
