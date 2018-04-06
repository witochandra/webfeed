import 'package:xml/xml.dart';

class AtomCategory {
  String term;
  String scheme;
  String label;

  AtomCategory(this.term, this.scheme, this.label);

  factory AtomCategory.parse(XmlElement element) {
    var term = element.getAttribute("term");
    var scheme = element.getAttribute("scheme");
    var label = element.getAttribute("label");
    return new AtomCategory(term, scheme, label);
  }

  @override
  String toString() {
    return '''
      term: $term
      scheme: $scheme
      label: $label
    ''';
  }
}