import 'package:xml/xml.dart';

class AtomGenerator {
  final Uri uri;
  final String version;
  final String value;

  AtomGenerator({
    this.uri,
    this.version,
    this.value,
  });

  factory AtomGenerator.parse(XmlElement element) {
    if (element == null) return null;
    var uri = element.getAttribute("uri");
    return AtomGenerator(
      uri: uri == null ? null : Uri.parse(uri),
      version: element.getAttribute("version"),
      value: element.text,
    );
  }
}
