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

  void build(XmlBuilder b) {
    b.element('link', nest: () {
      if (rel != null) b.attribute('rel', rel);
      if (type != null) b.attribute('type', type);
      if (hreflang != null) b.attribute('hreflang', hreflang);
      if (href != null) b.attribute('href', href);
      if (title != null) b.attribute('title', title);
      if (length != null) b.attribute('length', length);
    });
  }
}
