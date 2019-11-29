import 'package:xml/xml.dart';

class AtomCategory {
  final String term;
  final String scheme;
  final String label;

  AtomCategory({this.term, this.scheme, this.label});

  factory AtomCategory.parse(XmlElement element) => AtomCategory(
        term: element.getAttribute("term"),
        scheme: element.getAttribute("scheme"),
        label: element.getAttribute("label"),
      );
}
