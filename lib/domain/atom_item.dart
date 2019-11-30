import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/domain/atom_source.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/util/helpers.dart';
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
  final DateTime published;
  final String content;
  final String summary;
  final String rights;
  final Media media;

  AtomItem({
    this.id,
    this.title,
    updated,
    this.authors,
    this.links,
    this.categories,
    this.contributors,
    this.source,
    published,
    this.content,
    this.summary,
    this.rights,
    this.media,
  })  : this.updated = updated ?? DateTime.now(),
        this.published = published ?? DateTime.now();

  factory AtomItem.parse(XmlElement element) => AtomItem(
        id: parseTextLiteral(element, "id"),
        title: parseTextLiteral(element, "title"),
        updated: parseDateTimeLiteral(element, "updated"),
        authors: element.findElements("author").map((e) => AtomPerson.parse(e)).toList(),
        links: element.findElements("link").map((e) => AtomLink.parse(e)).toList(),
        categories: element.findElements("category").map((e) => AtomCategory.parse(e)).toList(),
        contributors: element.findElements("contributor").map((e) => AtomPerson.parse(e)).toList(),
        source: AtomSource.parse(findElementOrNull(element, "source")),
        published: parseDateTimeLiteral(element, "published"),
        content: parseTextLiteral(element, "content"),
        summary: parseTextLiteral(element, "summary"),
        rights: parseTextLiteral(element, "rights"),
        media: Media.parse(element),
      );

  void build(XmlBuilder b) {
    if (id == null || id.isEmpty) throw Exception('must have an id');
    b.element('entry', nest: () {
      b.element('id', nest: () => b.text(id));
      if (title != null) b.element('title', nest: () => b.text(title));
      if (updated != null) b.element('updated', nest: () => b.text(updated.toUtc().toIso8601String()));
      if (authors != null) authors.forEach((a) => a.build(b, 'author'));
      if (links != null) links.forEach((l) => l.build(b));
      if (categories != null) categories.forEach((c) => c.build(b));
      if (contributors != null) contributors.forEach((c) => c.build(b, 'contributor'));
      if (source != null) source.build(b);
      if (published != null) b.element('published', nest: () => b.text(published.toUtc().toIso8601String()));
      if (summary != null) b.element('summary', nest: () => b.text(summary));
      if (content != null) b.element('content', nest: () => b.text(content));
      if (rights != null) b.element('rights', nest: () => b.text(rights));
      //if (media != null) media.build(b); // TODO
    });
  }
}
