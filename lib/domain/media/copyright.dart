import 'package:xml/xml.dart';

class Copyright {
  final Uri url;
  final String value;

  Copyright({
    this.url,
    this.value,
  });

  factory Copyright.parse(XmlElement element) {
    if (element == null) return null;
    var url = element.getAttribute("url");
    return Copyright(
      url: url == null ? null : Uri.parse(url),
      value: element.text,
    );
  }
}
