import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomSource {
  final Uri id;
  final String title;
  final DateTime updated;

  AtomSource({
    this.id,
    this.title,
    updated,
  }) : this.updated = updated ?? DateTime.now();

  factory AtomSource.parse(XmlElement element) {
    if (element == null) return null;
    var id = parseTextLiteral(element, 'id');
    return AtomSource(
      id: id == null ? null : Uri.parse(id),
      title: parseTextLiteral(element, 'title'),
      updated: parseDateTimeLiteral(element, 'updated'),
    );
  }

  void build(XmlBuilder b) {
    if (id == null) throw Exception('must have id');
    b.element('source', nest: () {
      b.element('id', nest: () => b.text(id));
      if (title != null) b.element('title', nest: () => b.text(title));
      if (updated != null) b.element('updated', nest: () => b.text(updated.toUtc().toIso8601String()));
    });
  }
}
