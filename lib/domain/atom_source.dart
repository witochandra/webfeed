import 'package:webfeed_plus/util/iterable.dart';
import 'package:xml/xml.dart';

class AtomSource {
  final String? id;
  final String? title;
  final String? updated;

  AtomSource({
    this.id,
    this.title,
    this.updated,
  });

  factory AtomSource.parse(XmlElement element) {
    return AtomSource(
      id: element.findElements('id').firstOrNull?.innerText,
      title: element.findElements('title').firstOrNull?.innerText,
      updated: element.findElements('updated').firstOrNull?.innerText,
    );
  }
}
