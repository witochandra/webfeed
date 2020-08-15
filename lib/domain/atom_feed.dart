import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_generator.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/util/datetime.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class AtomFeed {
  final String id;
  final String title;
  final DateTime updated;
  final List<AtomItem> items;

  final List<AtomLink> links;
  final List<AtomPerson> authors;
  final List<AtomPerson> contributors;
  final List<AtomCategory> categories;
  final AtomGenerator generator;
  final String icon;
  final String logo;
  final String rights;
  final String subtitle;

  AtomFeed({
    this.id,
    this.title,
    this.updated,
    this.items,
    this.links,
    this.authors,
    this.contributors,
    this.categories,
    this.generator,
    this.icon,
    this.logo,
    this.rights,
    this.subtitle,
  });

  factory AtomFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    var feedElement = findFirstElement(document, 'feed');
    if (feedElement == null) {
      throw ArgumentError('feed not found');
    }

    return AtomFeed(
      id: findFirstElement(feedElement, 'id')?.text,
      title: findFirstElement(feedElement, 'title')?.text,
      updated: parseDateTime(findFirstElement(feedElement, 'updated')?.text),
      items: feedElement
          .findElements('entry')
          .map((e) => AtomItem.parse(e))
          .toList(),
      links: feedElement
          .findElements('link')
          .map((e) => AtomLink.parse(e))
          .toList(),
      authors: feedElement
          .findElements('author')
          .map((e) => AtomPerson.parse(e))
          .toList(),
      contributors: feedElement
          .findElements('contributor')
          .map((e) => AtomPerson.parse(e))
          .toList(),
      categories: feedElement
          .findElements('category')
          .map((e) => AtomCategory.parse(e))
          .toList(),
      generator:
          AtomGenerator.parse(findFirstElement(feedElement, 'generator')),
      icon: findFirstElement(feedElement, 'icon')?.text,
      logo: findFirstElement(feedElement, 'logo')?.text,
      rights: findFirstElement(feedElement, 'rights')?.text,
      subtitle: findFirstElement(feedElement, 'subtitle')?.text,
    );
  }
}
