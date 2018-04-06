import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_generator.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:xml/xml.dart';
import 'package:webfeed/util/helpers.dart';

class AtomFeed {
  String id;
  String title;
  String updated;
  List<AtomItem> items;

  List<AtomLink> links;
  List<AtomPerson> authors;
  List<AtomPerson> contributors;
  List<AtomCategory> categories;
  AtomGenerator generator;
  String icon;
  String logo;
  String rights;
  String subtitle;

  AtomFeed(this.id, this.title, this.updated, this.items,
      {this.links, this.authors, this.contributors, this.categories, this.generator, this.icon, this.logo, this.rights, this.subtitle});

  factory AtomFeed.parse(String xmlString) {
    var document = parse(xmlString);
    XmlElement feedElement;
    try {
      feedElement = document.findElements("feed").first;
    } on StateError {
      throw new ArgumentError("feed not found");
    }
    var id = xmlGetString(feedElement, "id");
    var title = xmlGetString(feedElement, "title");
    var updated = xmlGetString(feedElement, "updated");
    
    var items = feedElement.findElements("entry").map((element) {
      return new AtomItem.parse(element);
    }).toList();

    var links = feedElement.findElements("link").map((element) {
      return new AtomLink.parse(element);
    }).toList();

    var authors = feedElement.findElements("author").map((element) {
      return new AtomPerson.parse(element);
    }).toList();

    var contributors = feedElement.findElements("contributor").map((element) {
      return new AtomPerson.parse(element);
    }).toList();

    var categories = feedElement.findElements("category").map((element) {
      return new AtomCategory.parse(element);
    }).toList();

    AtomGenerator generator;
    try {
      generator = new AtomGenerator.parse(feedElement.findElements("generator").first);
    } on StateError {}

    var icon = xmlGetString(feedElement, "icon", strict: false);
    var logo = xmlGetString(feedElement, "logo", strict: false);
    var rights = xmlGetString(feedElement, "rights", strict: false);
    var subtitle = xmlGetString(feedElement, "subtitle", strict: false);

    return new AtomFeed(id, title, updated, items,
        links: links,
        authors: authors,
        contributors: contributors,
        categories: categories,
        generator: generator,
        icon: icon,
        logo: logo,
        rights: rights,
        subtitle: subtitle);
  }
}
