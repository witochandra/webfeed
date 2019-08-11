import 'package:xml/xml.dart';

import 'package:webfeed/util/helpers.dart';

import 'rss_itunes_category.dart';
import 'rss_itunes_image.dart';

class RssItunes {
  final String author;
  final String summary;
  final bool explicit;
  final String subtitle;
  final RssItunesOwner owner;
  final List<String> keywords;
  final RssItunesImage image;
  final RssItunesCategory category;

  RssItunes({
    this.author,
    this.summary,
    this.explicit,
    this.subtitle,
    this.owner,
    this.keywords,
    this.image,
    this.category,
  });

  factory RssItunes.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    var explicitStr =
        findElementOrNull(element, "itunes:explicit")?.text?.toLowerCase()?.trim();

    return RssItunes(
      author: findElementOrNull(element, "itunes:author")?.text?.trim(),
      summary: findElementOrNull(element, "itunes:summary")?.text?.trim(),
      explicit: explicitStr == null
          ? null
          : explicitStr == "yes" || explicitStr == "true",
      subtitle: findElementOrNull(element, "itunes:subtitle")?.text?.trim(),
      owner: RssItunesOwner.parse(findElementOrNull(element, "itunes:owner")),
      keywords: findElementOrNull(element, "itunes:keywords")?.text?.split(",")?.map((keyword) => keyword.trim())?.toList(),
      image: RssItunesImage.parse(findElementOrNull(element, "itunes:image")),
      category: RssItunesCategory.parse(
          findElementOrNull(element, "itunes:category")),
    );
  }
}

class RssItunesOwner {
  final String name;
  final String email;

  RssItunesOwner({this.name, this.email});

  factory RssItunesOwner.parse(XmlElement element) {
    if (element == null) return null;
    return RssItunesOwner(
      name: findElementOrNull(element, "itunes:name")?.text?.trim(),
      email: findElementOrNull(element, "itunes:email")?.text?.trim(),
    );
  }
}
