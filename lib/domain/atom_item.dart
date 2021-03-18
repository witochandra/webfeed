import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/domain/atom_source.dart';
import 'package:webfeed/domain/geo/geo.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/util/datetime.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class AtomItem {
  final String id;
  final String title;
  final DateTime updated;

  final List<AtomPerson> authors;
  final List<AtomLink> links;
  final List<AtomCategory> categories;
  final List<AtomPerson> contributors;
  final AtomSource source;
  final String published;
  final String content;
  final String summary;
  final String rights;
  final Media media;
  final Geo geo;

  AtomItem({
    this.id,
    this.title,
    this.updated,
    this.authors,
    this.links,
    this.categories,
    this.contributors,
    this.source,
    this.published,
    this.content,
    this.summary,
    this.rights,
    this.media,
    this.geo,
  });

  factory AtomItem.parse(XmlElement element) {
    return AtomItem(
      id: findFirstElement(element, 'id')?.text,
      title: findFirstElement(element, 'title')?.text,
      updated: parseDateTime(findFirstElement(element, 'updated')?.text),
      authors: element
          .findElements('author')
          .map((e) => AtomPerson.parse(e))
          .toList(),
      links:
          element.findElements('link').map((e) => AtomLink.parse(e)).toList(),
      categories: element
          .findElements('category')
          .map((e) => AtomCategory.parse(e))
          .toList(),
      contributors: element
          .findElements('contributor')
          .map((e) => AtomPerson.parse(e))
          .toList(),
      source: AtomSource.parse(findFirstElement(element, 'source')),
      published: findFirstElement(element, 'published')?.text,
      content: findFirstElement(element, 'content')?.text,
      summary: findFirstElement(element, 'summary')?.text,
      rights: findFirstElement(element, 'rights')?.text,
      media: Media.parse(element),
      geo: Geo.parse(element),
    );
  }
}
