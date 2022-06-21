import 'package:webfeed/domain/media/license.dart';
import 'package:webfeed/domain/podcast/podcast_funding.dart';
import 'package:webfeed/domain/podcast/podcast_guid.dart';
import 'package:webfeed/domain/podcast/podcast_images.dart';
import 'package:webfeed/domain/podcast/podcast_live_item.dart';
import 'package:webfeed/domain/podcast/podcast_location.dart';
import 'package:webfeed/domain/podcast/podcast_locked.dart';
import 'package:webfeed/domain/podcast/podcast_medium.dart';
import 'package:webfeed/domain/podcast/podcast_person.dart';
import 'package:webfeed/domain/podcast/podcast_trailer.dart';
import 'package:webfeed/domain/podcast/podcast_value.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:xml/xml.dart';

class Podcast {
  final Locked? locked;
  final Funding? funding;
  final List<Person> people;
  final Location? location;
  final List<Trailer> trailers;
  final License? license;
  final Guid? guid;
  final Value? value;
  final Medium? medium;
  final Images? images;
  final List<LiveItem> liveItems;

  Podcast({
    this.locked,
    this.funding,
    required this.people,
    this.location,
    required this.trailers,
    this.license,
    this.guid,
    this.value,
    this.medium,
    this.images,
    required this.liveItems,
  });

  factory Podcast.parse(XmlElement element) {
    return Podcast(
      locked: element
          .findElements('podcast:locked')
          .map((e) => Locked.parse(e))
          .firstOrNull,
      funding: element
          .findElements('podcast:funding')
          .map((e) => Funding.parse(e))
          .firstOrNull,
      people: element
          .findElements('podcast:person')
          .map((e) => Person.parse(e))
          .toList(),
      location: element
          .findElements('podcast:location')
          .map((e) => Location.parse(e))
          .firstOrNull,
      trailers: element
          .findElements('podcast:trailer')
          .map((e) => Trailer.parse(e))
          .toList(),
      license: element
          .findElements('podcast:license')
          .map((e) => License.parse(e))
          .firstOrNull,
      guid: element
          .findElements('podcast:guid')
          .map((e) => Guid.parse(e))
          .firstOrNull,
      value: element
          .findElements('podcast:value')
          .map((e) => Value.parse(e))
          .firstOrNull,
      medium: element
          .findElements('podcast:medium')
          .map((e) => Medium.parse(e))
          .firstOrNull,
      images: element
          .findElements('podcast:images')
          .map((e) => Images.parse(e))
          .firstOrNull,
      liveItems: element
          .findElements('podcast:liveItem')
          .map((e) => LiveItem.parse(e))
          .toList(),
    );
  }
}
