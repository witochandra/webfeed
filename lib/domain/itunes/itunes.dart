import 'package:webfeed/domain/itunes/itunes_category.dart';
import 'package:webfeed/domain/itunes/itunes_episode_type.dart';
import 'package:webfeed/domain/itunes/itunes_image.dart';
import 'package:webfeed/domain/itunes/itunes_owner.dart';
import 'package:webfeed/domain/itunes/itunes_type.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class Itunes {
  final String? author;
  final String? summary;
  final bool? explicit;
  final String? title;
  final String? subtitle;
  final ItunesOwner? owner;
  final List<String>? keywords;
  final ItunesImage? image;
  final List<ItunesCategory>? categories;
  final ItunesType? type;
  final String? newFeedUrl;
  final bool? block;
  final bool? complete;
  final int? episode;
  final int? season;
  final Duration? duration;
  final ItunesEpisodeType? episodeType;

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
    final episodeStr =
        element.findElements('itunes:episode').firstOrNull?.text ?? '';
    final seasonStr =
        element.findElements('itunes:season').firstOrNull?.text ?? '';
    final durationStr =
        element.findElements('itunes:duration').firstOrNull?.text ?? '';
    return Itunes(
      author: element.findElements('itunes:author').firstOrNull?.text,
      summary: element.findElements('itunes:summary').firstOrNull?.text,
      explicit: parseBoolLiteral(element, 'itunes:explicit'),
      title: element.findElements('itunes:title').firstOrNull?.text,
      subtitle: element.findElements('itunes:subtitle').firstOrNull?.text,
      owner: element
          .findElements('itunes:owner')
          .map((e) => ItunesOwner.parse(e))
          .firstOrNull,
      keywords: element
              .findElements('itunes:keywords')
              .firstOrNull
              ?.text
              .split(',')
              .map((keyword) => keyword.trim())
              .toList() ??
          [],
      image: element
          .findElements('itunes:image')
          .map((e) => ItunesImage.parse(e))
          .firstOrNull,
      categories: element
          .findElements('itunes:category')
          .map((e) => ItunesCategory.parse(e))
          .toList(),
      type: element
          .findElements('itunes:type')
          .map((e) => newItunesType(e))
          .firstOrNull,
      newFeedUrl: element.findElements('itunes:new-feed-url').firstOrNull?.text,
      block: parseBoolLiteral(element, 'itunes:block'),
      complete: parseBoolLiteral(element, 'itunes:complete'),
      episode: episodeStr.isNotEmpty ? int.tryParse(episodeStr) : null,
      season: seasonStr.isNotEmpty ? int.tryParse(seasonStr) : null,
      duration: durationStr.isNotEmpty ? _parseDuration(durationStr) : null,
      episodeType: element
          .findElements('itunes:episodeType')
          .map((e) => newItunesEpisodeType(e))
          .firstOrNull,
    );
  }

  static Duration _parseDuration(String s) {
    var hours = 0;
    var minutes = 0;
    var seconds = 0;
    var parts = s.split(s.contains(':') ? ':' : '.');
    if (parts.length > 2) {
      hours = int.tryParse(parts[parts.length - 3]) ?? 0;
    }
    if (parts.length > 1) {
      minutes = int.tryParse(parts[parts.length - 2]) ?? 0;
    }
    seconds = int.tryParse(parts[parts.length - 1]) ?? 0;
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }
}
