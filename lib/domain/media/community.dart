import 'package:webfeed_revised/domain/media/star_rating.dart';
import 'package:webfeed_revised/domain/media/statistics.dart';
import 'package:webfeed_revised/domain/media/tags.dart';
import 'package:webfeed_revised/util/iterable.dart';
import 'package:xml/xml.dart';

class Community {
  final StarRating? starRating;
  final Statistics? statistics;
  final Tags? tags;

  Community({
    this.starRating,
    this.statistics,
    this.tags,
  });

  factory Community.parse(XmlElement element) {
    return Community(
      starRating: element
          .findElements('media:starRating')
          .map((e) => StarRating.parse(e))
          .firstOrNull,
      statistics: element
          .findElements('media:statistics')
          .map((e) => Statistics.parse(e))
          .firstOrNull,
      tags: element
          .findElements('media:tags')
          .map((e) => Tags.parse(e))
          .firstOrNull,
    );
  }
}
