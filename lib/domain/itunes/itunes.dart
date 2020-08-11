import 'package:webfeed/domain/itunes/itunes_category.dart';
import 'package:webfeed/domain/itunes/itunes_episode_type.dart';
import 'package:webfeed/domain/itunes/itunes_image.dart';
import 'package:webfeed/domain/itunes/itunes_owner.dart';
import 'package:webfeed/domain/itunes/itunes_type.dart';
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
    var episodeStr = findElementOrNull(element, 'itunes:episode')?.text?.trim();
    var seasonStr = findElementOrNull(element, 'itunes:season')?.text?.trim();
    var durationStr =
        findElementOrNull(element, 'itunes:duration')?.text?.trim();
    return Itunes(
      author: findElementOrNull(element, 'itunes:author')?.text?.trim(),
      summary: findElementOrNull(element, 'itunes:summary')?.text?.trim(),
      explicit: parseBoolLiteral(element, 'itunes:explicit'),
      title: findElementOrNull(element, 'itunes:title')?.text?.trim(),
      subtitle: findElementOrNull(element, 'itunes:subtitle')?.text?.trim(),
      owner: ItunesOwner.parse(findElementOrNull(element, 'itunes:owner')),
      keywords: findElementOrNull(element, 'itunes:keywords')
          ?.text
          ?.split(',')
          ?.map((keyword) => keyword.trim())
          ?.toList(),
      image: ItunesImage.parse(findElementOrNull(element, 'itunes:image')),
      categories: findAllDirectElementsOrNull(element, 'itunes:category')
          .map((ele) => ItunesCategory.parse(ele))
          .toList(),
      type: newItunesType(findElementOrNull(element, 'itunes:type')),
      newFeedUrl:
          findElementOrNull(element, 'itunes:new-feed-url')?.text?.trim(),
      block: parseBoolLiteral(element, 'itunes:block'),
      complete: parseBoolLiteral(element, 'itunes:complete'),
      episode: episodeStr == null ? null : int.parse(episodeStr),
      season: seasonStr == null ? null : int.parse(seasonStr),
      duration: durationStr == null ? null : _parseDuration(durationStr),
      episodeType: newItunesEpisodeType(
          findElementOrNull(element, 'itunes:episodeType')),
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
