import 'package:xml/xml.dart';

class AtomGenerator {
  String uri;
  String version;
  String value;

  AtomGenerator(this.uri, this.version, this.value);

  factory AtomGenerator.parse(XmlElement element) {
    var uri = element.getAttribute("uri");
    var version = element.getAttribute("version");
    var value = element.text;
    return new AtomGenerator(uri, version, value);
  }

  @override
  String toString() {
    return '''
      uri: $uri
      version: $version
      value: $value
    ''';
  }
}