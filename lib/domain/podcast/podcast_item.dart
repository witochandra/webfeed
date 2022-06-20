import 'package:webfeed/domain/media/license.dart';
import 'package:webfeed/domain/podcast/podcast_alternate_enclosure.dart';
import 'package:webfeed/domain/podcast/podcast_chapters.dart';
import 'package:webfeed/domain/podcast/podcast_content_link.dart';
import 'package:webfeed/domain/podcast/podcast_episode.dart';
import 'package:webfeed/domain/podcast/podcast_images.dart';
import 'package:webfeed/domain/podcast/podcast_location.dart';
import 'package:webfeed/domain/podcast/podcast_person.dart';
import 'package:webfeed/domain/podcast/podcast_season.dart';
import 'package:webfeed/domain/podcast/podcast_soundbite.dart';
import 'package:webfeed/domain/podcast/podcast_transcript.dart';
import 'package:webfeed/domain/podcast/podcast_value.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:xml/xml.dart';

class PodcastItem {
  final Transcript? transcript;
  final Chapters? chapters;
  final List<Soundbite> soundbites;
  final List<Person> people;
  final Location? location;
  final Season? season;
  final Episode? episode;
  final License? license;
  final List<AlternateEnclosure> alternateEnclosures;
  final Value? value;
  final Images? images;
  final List<ContentLink> contentLinks;

  PodcastItem({
    this.transcript,
    this.chapters,
    required this.soundbites,
    required this.people,
    this.location,
    this.season,
    this.episode,
    this.license,
    required this.alternateEnclosures,
    this.value,
    this.images,
    required this.contentLinks,
  });

  factory PodcastItem.parse(XmlElement element) {
    return PodcastItem(
      transcript: element
          .findElements('podcast:transcript')
          .map((e) => Transcript.parse(e))
          .firstOrNull,
      chapters: element
          .findElements('podcast:chapters')
          .map((e) => Chapters.parse(e))
          .firstOrNull,
      soundbites: element
          .findElements('podcast:soundbite')
          .map((e) => Soundbite.parse(e))
          .toList(),
      people: element
          .findElements('podcast:person')
          .map((e) => Person.parse(e))
          .toList(),
      location: element
          .findElements('podcast:location')
          .map((e) => Location.parse(e))
          .firstOrNull,
      season: element
          .findElements('podcast:season')
          .map((e) => Season.parse(e))
          .firstOrNull,
      episode: element
          .findElements('podcast:episode')
          .map((e) => Episode.parse(e))
          .firstOrNull,
      license: element
          .findElements('podcast:license')
          .map((e) => License.parse(e))
          .firstOrNull,
      alternateEnclosures: element
          .findElements('podcast:alternateEnclosure')
          .map((e) => AlternateEnclosure.parse(e))
          .toList(),
      value: element
          .findElements('podcast:value')
          .map((e) => Value.parse(e))
          .firstOrNull,
      images: element
          .findElements('podcast:images')
          .map((e) => Images.parse(e))
          .firstOrNull,
      contentLinks: element
          .findElements('podcast:contentLink')
          .map((e) => ContentLink.parse(e))
          .toList(),
    );
  }
}
