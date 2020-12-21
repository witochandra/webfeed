import 'package:webfeed/domain/itunes/itunes_category.dart';
import 'package:webfeed/domain/itunes/itunes_episode_type.dart';
import 'package:webfeed/domain/itunes/itunes_image.dart';
import 'package:webfeed/domain/itunes/itunes_owner.dart';
import 'package:webfeed/domain/itunes/itunes_type.dart';
import 'package:webfeed/util/string.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class Itunes {
  final String author;
  final String summary;
  final bool explicit;
  final String title;
  final String subtitle;
  final ItunesOwner owner;
  final List<String> keywords;
  final ItunesImage image;
  final List<ItunesCategory> categories;
  final ItunesType type;
  final String newFeedUrl;
  final bool block;
  final bool complete;
  final int episode;
  final int season;
  final Duration duration;
  final ItunesEpisodeType episodeType;

  Itunes({
    this.author,
    this.summary,
    this.explicit,
    this.title,
    this.subtitle,
    this.owner,
    this.keywords,
    this.image,
    this.categories,
    this.type,
    this.newFeedUrl,
    this.block,
    this.complete,
    this.episode,
    this.season,
    this.duration,
    this.episodeType,
  });

  factory Itunes.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    var episodeStr = findFirstElement(element, 'itunes:episode')?.text;
    var seasonStr = findFirstElement(element, 'itunes:season')?.text;
    var durationStr = findFirstElement(element, 'itunes:duration')?.text;
    return Itunes(
      author: findFirstElement(element, 'itunes:author')?.text,
      summary: findFirstElement(element, 'itunes:summary')?.text,
      explicit: parseBoolLiteral(element, 'itunes:explicit'),
      title: findFirstElement(element, 'itunes:title')?.text,
      subtitle: findFirstElement(element, 'itunes:subtitle')?.text,
      owner: ItunesOwner.parse(findFirstElement(element, 'itunes:owner')),
      keywords: findFirstElement(element, 'itunes:keywords')
              ?.text
              ?.split(',')
              ?.map((keyword) => keyword.trim())
              ?.toList() ??
          [],
      image: ItunesImage.parse(findFirstElement(element, 'itunes:image')),
      categories: findElements(element, 'itunes:category')
          .map((e) => ItunesCategory.parse(e))
          .toList(),
      type: newItunesType(findFirstElement(element, 'itunes:type')),
      newFeedUrl: findFirstElement(element, 'itunes:new-feed-url')?.text,
      block: parseBoolLiteral(element, 'itunes:block'),
      complete: parseBoolLiteral(element, 'itunes:complete'),
      episode: isNullOrEmpty(episodeStr) ? null : int.parse(episodeStr),
      season: isNullOrEmpty(seasonStr) ? null : int.parse(seasonStr),
      duration: isNullOrEmpty(durationStr) ? null : _parseDuration(durationStr),
      episodeType:
          newItunesEpisodeType(findFirstElement(element, 'itunes:episodeType')),
    );
  }

  static Duration _parseDuration(String s) {
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
}
