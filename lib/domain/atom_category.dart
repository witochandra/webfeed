import 'package:xml/xml.dart';

class AtomCategory {
  final String term;
  final String scheme;
  final String label;

  AtomCategory({
    this.term,
    this.scheme,
    this.label,
  });

  factory AtomCategory.parse(XmlElement element) => AtomCategory(
        term: element.getAttribute("term"),
        scheme: element.getAttribute("scheme"),
        label: element.getAttribute("label"),
      );

  void build(XmlBuilder b) {
    b.element('category', nest: () {
      if (term != null) b.attribute('term', term);
      if (scheme != null) b.attribute('scheme', scheme);
      if (label != null) b.attribute('label', label);
    });
  }
}
