import 'package:webfeed/util/datetime.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class DublinCore {
  final String title;
  final String description;
  final String creator;
  final String subject;
  final String publisher;
  final String contributor;
  final DateTime date;
  final DateTime created;
  final DateTime modified;
  final String type;
  final String format;
  final String identifier;
  final String source;
  final String language;
  final String relation;
  final String coverage;
  final String rights;

  DublinCore({
    this.title,
    this.description,
    this.creator,
    this.subject,
    this.publisher,
    this.contributor,
    this.date,
    this.created,
    this.modified,
    this.type,
    this.format,
    this.identifier,
    this.source,
    this.language,
    this.relation,
    this.coverage,
    this.rights,
  });

  factory DublinCore.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    return DublinCore(
      title: findFirstElement(element, 'dc:title')?.text,
      description: findFirstElement(element, 'dc:description')?.text,
      creator: findFirstElement(element, 'dc:creator')?.text,
      subject: findFirstElement(element, 'dc:subject')?.text,
      publisher: findFirstElement(element, 'dc:publisher')?.text,
      contributor: findFirstElement(element, 'dc:contributor')?.text,
      date: parseDateTime(findFirstElement(element, 'dc:date')?.text),
      created: parseDateTime(findFirstElement(element, 'dc:created')?.text),
      modified: parseDateTime(findFirstElement(element, 'dc:modified')?.text),
      type: findFirstElement(element, 'dc:type')?.text,
      format: findFirstElement(element, 'dc:format')?.text,
      identifier: findFirstElement(element, 'dc:identifier')?.text,
      source: findFirstElement(element, 'dc:source')?.text,
      language: findFirstElement(element, 'dc:language')?.text,
      relation: findFirstElement(element, 'dc:relation')?.text,
      coverage: findFirstElement(element, 'dc:coverage')?.text,
      rights: findFirstElement(element, 'dc:rights')?.text,
    );
  }
}
