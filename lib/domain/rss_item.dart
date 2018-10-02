import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_content.dart';
import 'package:webfeed/domain/rss_enclosure.dart';
import 'package:webfeed/domain/rss_source.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';
import 'package:webfeed/util/helpers.dart';

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
  final RssEnclosure enclosure;

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
    this.enclosure,
  });

  factory RssItem.parse(XmlElement element) {
    return new RssItem(
      title: findElementOrNull(element, "title")?.text,
      description: findElementOrNull(element, "description")?.text,
      link: findElementOrNull(element, "link")?.text,
      categories: element.findElements("category").map((element) {
        return new RssCategory.parse(element);
      }).toList(),
      guid: findElementOrNull(element, "guid")?.text,
      pubDate: findElementOrNull(element, "pubDate")?.text,
      author: findElementOrNull(element, "author")?.text,
      comments: findElementOrNull(element, "comments")?.text,
      source: RssSource.parse(findElementOrNull(element, "source")),
      content: RssContent.parse(findElementOrNull(element, "content:encoded")),
      media: Media.parse(element),
      enclosure: RssEnclosure.parse(findElementOrNull(element, "enclosure")),
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
