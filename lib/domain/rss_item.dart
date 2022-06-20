import 'package:webfeed/domain/dublin_core/dublin_core.dart';
import 'package:webfeed/domain/itunes/itunes.dart';
import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/podcast/podcast_item.dart';
import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_content.dart';
import 'package:webfeed/domain/rss_enclosure.dart';
import 'package:webfeed/domain/rss_source.dart';
import 'package:webfeed/util/datetime.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:xml/xml.dart';

class RssItem {
  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory>? categories;
  final String? guid;
  final DateTime? pubDate;
  final String? author;
  final String? comments;
  final RssSource? source;
  final RssContent? content;
  final Media? media;
  final RssEnclosure? enclosure;
  final DublinCore? dc;
  final Itunes? itunes;
  final PodcastItem podcast;

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
    this.dc,
    this.itunes,
    required this.podcast,
  });

  factory RssItem.parse(XmlElement element) {
    return RssItem(
      title: element.findElements('title').firstOrNull?.text,
      description: element.findElements('description').firstOrNull?.text,
      link: element.findElements('link').firstOrNull?.text,
      categories: element
          .findElements('category')
          .map((e) => RssCategory.parse(e))
          .toList(),
      guid: element.findElements('guid').firstOrNull?.text,
      pubDate: parseDateTime(element.findElements('pubDate').firstOrNull?.text),
      author: element.findElements('author').firstOrNull?.text,
      comments: element.findElements('comments').firstOrNull?.text,
      source: element
          .findElements('source')
          .map((e) => RssSource.parse(e))
          .firstOrNull,
      content: element
          .findElements('content:encoded')
          .map((e) => RssContent.parse(e))
          .firstOrNull,
      media: Media.parse(element),
      enclosure: element
          .findElements('enclosure')
          .map((e) => RssEnclosure.parse(e))
          .firstOrNull,
      dc: DublinCore.parse(element),
      itunes: Itunes.parse(element),
      podcast: PodcastItem.parse(element),
    );
  }
}
