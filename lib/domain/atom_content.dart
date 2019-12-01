import 'package:xml/xml.dart';

class AtomContent {
  String type;
  String text;

  AtomContent({
    this.type,
    this.text,
  });

  factory AtomContent.parse(XmlElement element) {
    if (element == null) return null;
    return AtomContent(
      type: element.getAttribute('type'),
      text: element.text,
    );
  }

  void build(XmlBuilder b, String kind) => b.element(kind, nest: () {
        if (type != null) b.attribute('type', type);
        if (text != null) b.text(text);
      });
}
