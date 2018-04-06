import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_source.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class RssItem {
  final String title;
  final String description;
  final String link;

  final List<RssCategory> categories;
  final String guid;
  final String pubDate;
  final String author;
  final String comments;
  final RssSource source;

  RssItem(this.title, this.description, this.link,
      {this.categories, this.guid, this.pubDate, this.author, this.comments, this.source});

  factory RssItem.parse(XmlElement element) {
    var title = xmlGetString(element, "title");
    var description = xmlGetString(element, "description");
    var link = xmlGetString(element, "link");

    var categories = element.findElements("category").map((element) {
      return new RssCategory.parse(element);
    }).toList();

    var guid = xmlGetString(element, "guid", strict: false);
    var pubDate = xmlGetString(element, "pubDate", strict: false);
    var author = xmlGetString(element, "author", strict: false);
    var comments = xmlGetString(element, "comments", strict: false);

    RssSource source;
    try {
      source = new RssSource.parse(element.findElements("source").first);
    } on StateError {}

    return new RssItem(title, description, link,
        categories: categories, guid: guid, pubDate: pubDate, author: author, comments: comments, source: source);
  }

  @override
  String toString() {
    return '''
      title: $title
      description: $description
      link: $link
      guid: $guid
      pubDate: $pubDate
      author: $author
      comments: $comments
      source: $source
    ''';
  }
}
