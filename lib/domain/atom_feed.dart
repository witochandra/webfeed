import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_generator.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/util/helpers.dart';
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
    var document = parse(xmlString);
    XmlElement feedElement;
    try {
      feedElement = document.findElements("feed").first;
    } on StateError {
      throw new ArgumentError("feed not found");
    }

    var updated = findElementOrNull(feedElement, "updated")?.text;

    return AtomFeed(
      id: findElementOrNull(feedElement, "id")?.text,
      title: findElementOrNull(feedElement, "title")?.text,
      updated: updated == null ? null : DateTime.parse(updated),
      items: feedElement.findElements("entry").map((element) {
        return AtomItem.parse(element);
      }).toList(),
      links: feedElement.findElements("link").map((element) {
        return AtomLink.parse(element);
      }).toList(),
      authors: feedElement.findElements("author").map((element) {
        return AtomPerson.parse(element);
      }).toList(),
      contributors: feedElement.findElements("contributor").map((element) {
        return AtomPerson.parse(element);
      }).toList(),
      categories: feedElement.findElements("category").map((element) {
        return AtomCategory.parse(element);
      }).toList(),
      generator: AtomGenerator.parse(findElementOrNull(feedElement, "generator")),
      icon: findElementOrNull(feedElement, "icon")?.text,
      logo: findElementOrNull(feedElement, "logo")?.text,
      rights: findElementOrNull(feedElement, "rights")?.text,
      subtitle: findElementOrNull(feedElement, "subtitle")?.text,
    );
  }

  XmlDocument toXml() {
    var doc = parse('<?xml version="1.0" encoding="UTF-8"?><feed xmlns="http://www.w3.org/2005/Atom"></feed>');

    var b = XmlBuilder();
    b.element('id', nest: () => b.text(id));
    b.element('title', nest: () => title == null ? null : b.text(title));
    b.element('updated', nest: () => b.text(updated.toUtc().toIso8601String()));

    var feed = doc.findAllElements('feed').first;
    b.build().children.forEach((c) => feed.children.add(c.copy()));

    return doc;
  }
}
