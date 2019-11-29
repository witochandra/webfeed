import 'package:xml/xml.dart';

class PeerLink {
  final String type;
  final Uri href;
  final String value;

  PeerLink({
    this.type,
    this.href,
    this.value,
  });

  factory PeerLink.parse(XmlElement element) {
    if (element == null) return null;
    var href = element.getAttribute("href");
    return PeerLink(
      type: element.getAttribute("type"),
      href: href == null ? null : Uri.parse(href),
      value: element.text,
    );
  }
}
