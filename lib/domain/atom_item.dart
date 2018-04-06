import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/domain/atom_source.dart';
import 'package:xml/xml.dart';
import 'package:webfeed/util/helpers.dart';

class AtomItem {
  String id;
  String title;
  String updated;

  List<AtomPerson> authors;
  List<AtomLink> links;
  List<AtomCategory> categories;
  List<AtomPerson> contributors;
  AtomSource source;
  String published;
  String content;
  String summary;
  String rights;

  AtomItem(this.id, this.title, this.updated,
      {this.authors,
      this.links,
      this.categories,
      this.contributors,
      this.source,
      this.published,
      this.content,
      this.summary,
      this.rights});

  factory AtomItem.parse(XmlElement element) {
    var id = xmlGetString(element, "id");
    var title = xmlGetString(element, "title");
    var updated = xmlGetString(element, "updated");

    var authors = element.findElements("author").map((element) {
      return new AtomPerson.parse(element);
    }).toList();

    var links = element.findElements("link").map((element) {
      return new AtomLink.parse(element);
    }).toList();

    var categories = element.findElements("category").map((element) {
      return new AtomCategory.parse(element);
    }).toList();

    var contributors = element.findElements("contributor").map((element) {
      return new AtomPerson.parse(element);
    }).toList();

    AtomSource source;
    try {
      source = new AtomSource.parse(element.findElements("source").first);
    } on StateError {}

    var published = xmlGetString(element, "published", strict: false);
    var content = xmlGetString(element, "content", strict: false);
    var summary = xmlGetString(element, "summary", strict: false);
    var rights = xmlGetString(element, "rights", strict: false);

    return new AtomItem(id, title, updated,
        authors: authors,
        links: links,
        categories: categories,
        contributors: contributors,
        source: source,
        published: published,
        content: content,
        summary: summary,
        rights: rights);
  }
}
