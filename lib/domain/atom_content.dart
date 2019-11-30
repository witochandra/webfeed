import 'package:xml/xml.dart';

class AtomContent {
  String type;
  String text;

  AtomContent({
    this.type,
    this.text,
  });

  factory AtomContent.parse(XmlElement element) => AtomContent(
        type: element.getAttribute('type'),
        text: element.text,
      );

  void build(XmlBuilder b) => b.element('content', nest: () {
        if (type != null) b.attribute('type', type);
        if (text != null) b.text(text);
      });
}
