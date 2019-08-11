import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_itunes_category.dart';
import 'rss_itunes_image.dart';

class RssItemItunes {
  final int episode;
  final Duration duration;
  final String episodeType;
  final String author;
  final String summary;
  final bool explicit;
  final String subtitle;
  final List<String> keywords;
  final RssItunesImage image;
  final RssItunesCategory category;

  RssItemItunes({
    this.episode,
    this.duration,
    this.episodeType,
    this.author,
    this.summary,
    this.explicit,
    this.subtitle,
    this.keywords,
    this.image,
    this.category,
  });

  factory RssItemItunes.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    var explicitStr =
        findElementOrNull(element, "itunes:explicit")?.text?.toLowerCase()?.trim();
    var episodeStr = findElementOrNull(element, "itunes:episode")?.text?.trim();
    var durationStr = findElementOrNull(element, "itunes:duration")?.text?.trim();

    return RssItemItunes(
      episode: episodeStr == null ? null : int.parse(episodeStr),
      duration: durationStr == null ? null : parseDuration(durationStr),
      episodeType: findElementOrNull(element, "itunes:episodeType")?.text?.trim(),
      author: findElementOrNull(element, "itunes:author")?.text?.trim(),
      summary: findElementOrNull(element, "itunes:summary")?.text?.trim(),
      explicit: explicitStr == null
          ? null
          : explicitStr == "yes" || explicitStr == "true",
      subtitle: findElementOrNull(element, "itunes:subtitle")?.text?.trim(),
      keywords: findElementOrNull(element, "itunes:keywords")?.text?.split(",")?.map((keyword) => keyword.trim())?.toList(),
      image: RssItunesImage.parse(findElementOrNull(element, "itunes:image")),
      category: RssItunesCategory.parse(
          findElementOrNull(element, "itunes:category")),
    );
  }
}

Duration parseDuration(String s) {
  var hours = 0;
  var minutes = 0;
  var seconds = 0;
  var parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  seconds = int.parse(parts[parts.length - 1]);
  return Duration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}
