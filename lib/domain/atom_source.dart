import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class AtomSource {
  final String id;
  final String title;
  final String updated;

  AtomSource({
    this.id,
    this.title,
    this.updated,
  });

  factory AtomSource.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    return AtomSource(
      id: findFirstElement(element, 'id')?.text,
      title: findFirstElement(element, 'title')?.text,
      updated: findFirstElement(element, 'updated')?.text,
    );
  }
}
