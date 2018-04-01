import 'package:webfeedclient/domain/rss_category.dart';
import 'package:webfeedclient/util/helpers.dart';
import 'package:xml/xml.dart';

class RssItem {
  final String title;
  final String description;
  final String link;

  final List<RssCategory> categories;
  final String guid;
  final String pubDate;

  RssItem(this.title, this.description, this.link, {this.categories, this.guid, this.pubDate});

  factory RssItem.parse(XmlElement element) {
    var title = xmlGetString(element, "title");
    var description = xmlGetString(element, "description");
    var link = xmlGetString(element, "link");

    List<RssCategory> categories = element.findElements("category").map((element) {
      return new RssCategory.parse(element);
    }).toList();

    var guid = xmlGetString(element, "guid", strict: false);
    var pubDate = xmlGetString(element, "pubDate", strict: false);

    return new RssItem(title, description, link, categories: categories, guid: guid, pubDate: pubDate);
  }

  @override
  String toString() {
    return '''
      title: $title
      description: $description
      link: $link
      pubDate: $pubDate
    ''';
  }
}
