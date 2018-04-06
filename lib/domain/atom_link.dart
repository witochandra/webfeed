import 'package:xml/xml.dart';

class AtomLink {
  String href;
  String rel;
  String type;
  String hreflang;
  String title;
  int length;

  AtomLink(this.href, this.rel, this.type, this.hreflang, this.title, this.length);

  factory AtomLink.parse(XmlElement element) {
    var href = element.getAttribute("href");
    var rel = element.getAttribute("rel");
    var type = element.getAttribute("type");
    var title = element.getAttribute("title");
    var hreflang = element.getAttribute("hreflang");
    var length = 0;
    if (element.getAttribute("length") != null) {
      length = int.parse(element.getAttribute("length"));
    }
    return new AtomLink(href, rel, type, hreflang, title, length);
  }

  @override
  String toString() {
    return '''
      href: $href
      rel: $rel
      type: $type
      hreflang: $hreflang
      title: $title
      length: $length
    ''';
  }
}