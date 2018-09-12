import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_content.dart';
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
  final RssContent content;
  final Media media;

  RssItem({
    this.title,
    this.description,
    this.link,
    this.categories,
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
  });

  factory RssItem.parse(XmlElement element) {
    var title = xmlGetString(element, "title", strict: false);
    var description = xmlGetString(element, "description", strict: false);
    var link = xmlGetString(element, "link", strict: false);

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

    RssContent content;
    try {
      content =
          new RssContent.parse(element.findElements("content:encoded").first);
    } on StateError {}

    return new RssItem(
      title: title,
      description: description,
      link: link,
      categories: categories,
      guid: guid,
      pubDate: pubDate,
      author: author,
      comments: comments,
      source: source,
      content: content,
      media: Media.parse(element),
    );
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
      content: $content
    ''';
  }
}
