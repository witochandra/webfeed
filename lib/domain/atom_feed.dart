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
    var document = parse(xmlString);
    XmlElement feedElement;
    try {
      feedElement = document.findElements("feed").first;
    } on StateError {
      throw new ArgumentError("feed not found");
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
    if (id == null) throw Exception('must have an id');
    var doc = parse('<?xml version="1.0" encoding="UTF-8"?><feed xmlns="http://www.w3.org/2005/Atom"></feed>');

    var b = XmlBuilder();
    b.element('id', nest: () => b.text(id));
    b.element('title', nest: () => title == null ? '' : b.text(title));
    b.element('updated', nest: () => b.text(updated.toUtc().toIso8601String()));

    for (var link in links ?? List<AtomLink>()) {
      b.element('link', nest: () {
        if (link.rel != null) b.attribute('rel', link.rel);
        if (link.type != null) b.attribute('type', link.type);
        if (link.hreflang != null) b.attribute('hreflang', link.hreflang);
        if (link.href != null) b.attribute('href', link.href);
        if (link.title != null) b.attribute('title', link.title);
        if (link.length != null) b.attribute('length', link.length);
      });
    }

    for (var author in authors ?? List<AtomPerson>()) {
      b.element('author', nest: () {
        if (author.name != null) b.element('name', nest: () => b.text(author.name));
        if (author.uri != null) b.element('uri', nest: () => b.text(author.uri));
        if (author.email != null) b.element('email', nest: () => b.text(author.email));
      });
    }

    for (var contributor in contributors ?? List<AtomPerson>()) {
      b.element('contributor', nest: () {
        if (contributor.name != null) b.element('name', nest: () => b.text(contributor.name));
        if (contributor.uri != null) b.element('uri', nest: () => b.text(contributor.uri));
        if (contributor.email != null) b.element('email', nest: () => b.text(contributor.email));
      });
    }

    var feed = doc.findAllElements('feed').first;
    b.build().children.forEach((c) => feed.children.add(c.copy()));

    return doc;
  }
}
