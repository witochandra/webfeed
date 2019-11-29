import 'package:xml/xml.dart';

class AtomLink {
  final Uri href;
  final String rel;
  final String type;
  final String hreflang;
  final String title;
  final int length;

  AtomLink({
    this.href,
    this.rel,
    this.type,
    this.hreflang,
    this.title,
    this.length,
  });

  factory AtomLink.parse(XmlElement element) {
    var href = element.getAttribute("href");
    return AtomLink(
      href: href == null ? null : Uri.parse(href),
      rel: element.getAttribute("rel"),
      type: element.getAttribute("type"),
      hreflang: element.getAttribute("hreflang"),
      title: element.getAttribute("title"),
      length: int.parse(element.getAttribute("length") ?? "0"),
    );
  }
}
