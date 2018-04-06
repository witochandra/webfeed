import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomSource {
  String id;
  String title;
  String updated;

  AtomSource(this.id, this.title, this.updated);

  factory AtomSource.parse(XmlElement element) {
    var id = xmlGetString(element, "id", strict: false);
    var title = xmlGetString(element, "title", strict: false);
    var updated = xmlGetString(element, "updated", strict: false);

    return new AtomSource(id, title, updated);
  }

  @override
  String toString() {
    return '''
      id: $id
      title: $title
      updated: $updated
    ''';
  }
}