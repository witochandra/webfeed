import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_generator.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomFeed {
  final Uri id;
  final String title;
  final DateTime updated;
  final List<AtomItem> items;
  final List<AtomLink> links;
  final List<AtomPerson> authors;
  final List<AtomPerson> contributors;
  final List<AtomCategory> categories;
  final AtomGenerator generator;
  final Uri icon;
  final Uri logo;
  final String rights;
  final String subtitle;

  AtomFeed({
    this.id,
    this.title,
    updated,
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
  }) : this.updated = updated ?? DateTime.now(); // default value

  factory AtomFeed.parse(String xmlString) {
    XmlElement feedElement;

    try {
      var document = parse(xmlString);
      feedElement = document.findElements("feed").first;
    } on StateError {
      throw ArgumentError("feed not found");
    }

    return AtomFeed(
      id: parseUriLiteral(feedElement, "id"),
      title: parseTextLiteral(feedElement, "title"),
      updated: parseDateTimeLiteral(feedElement, "updated"),
      items: feedElement.findElements("entry").map((e) => AtomItem.parse(e)).toList(),
      links: feedElement.findElements("link").map((e) => AtomLink.parse(e)).toList(),
      authors: feedElement.findElements("author").map((e) => AtomPerson.parse(e)).toList(),
      contributors: feedElement.findElements("contributor").map((e) => AtomPerson.parse(e)).toList(),
      categories: feedElement.findElements("category").map((e) => AtomCategory.parse(e)).toList(),
      generator: AtomGenerator.parse(findElementOrNull(feedElement, "generator")),
      icon: parseUriLiteral(feedElement, "icon"),
      logo: parseUriLiteral(feedElement, "logo"),
      rights: parseTextLiteral(feedElement, "rights"),
      subtitle: parseTextLiteral(feedElement, "subtitle"),
    );
  }

  XmlDocument toXml() {
    var doc = parse('<?xml version="1.0" encoding="UTF-8"?><feed xmlns="http://www.w3.org/2005/Atom"></feed>');
    var b = XmlBuilder();
    build(b);
    var feed = doc.findAllElements('feed').first;
    b.build().children.forEach((c) => feed.children.add(c.copy()));
    return doc;
  }

  void build(XmlBuilder b) {
    if (id == null) throw Exception('must have an id');

    b.element('id', nest: () => b.text(id));
    b.element('title', nest: () => title == null ? '' : b.text(title));
    b.element('updated', nest: () => b.text(updated.toUtc().toIso8601String()));

    if (links != null) links.forEach((l) => l.build(b));
    if (authors != null) authors.forEach((a) => a.build(b, 'author'));
    if (contributors != null) contributors.forEach((c) => c.build(b, 'contributor'));
    if (categories != null) categories.forEach((c) => c.build(b));
    if (generator != null) generator.build(b);

    if (icon != null) b.element('icon', nest: () => b.text(icon));
    if (logo != null) b.element('logo', nest: () => b.text(logo));
    if (subtitle != null) b.element('subtitle', nest: () => b.text(subtitle));
  }
}
