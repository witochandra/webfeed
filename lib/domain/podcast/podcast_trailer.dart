import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#trailer
class Trailer {
  final String? url;
  final String? pubdate;
  final int? length;
  final String? type;
  final int? season;
  final String? value;

  Trailer({
    this.url,
    this.pubdate,
    this.length,
    this.type,
    this.season,
    this.value,
  });

  factory Trailer.parse(XmlElement element) {
    final lengthStr = element.getAttribute('length');
    final seasonStr = element.getAttribute('season');
    return Trailer(
      url: element.getAttribute('url'),
      pubdate: element.getAttribute('pubdate'),
      length: lengthStr == null ? null : int.tryParse(lengthStr),
      type: element.getAttribute('type'),
      season: seasonStr == null ? null : int.tryParse(seasonStr),
      value: element.text,
    );
  }
}
