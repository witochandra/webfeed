import 'package:webfeed/domain/podcast/podcast_integrity.dart';
import 'package:webfeed/domain/podcast/podcast_source.dart';
import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#alternate-enclosure
class AlternateEnclosure {
  final String? type;
  final int? length;
  final int? bitrate;
  final int? height;
  final String? lang;
  final String? title;
  final String? rel;
  final String? codecs;
  final String? default_;
  final List<Source> sources;
  final List<Integrity> integrities;

  AlternateEnclosure({
    this.type,
    this.length,
    this.bitrate,
    this.height,
    this.lang,
    this.title,
    this.rel,
    this.codecs,
    this.default_,
    required this.sources,
    required this.integrities,
  });

  factory AlternateEnclosure.parse(XmlElement element) {
    final lengthStr = element.getAttribute('length');
    final bitrateStr = element.getAttribute('bitrate');
    final heightStr = element.getAttribute('height');
    return AlternateEnclosure(
      type: element.getAttribute('type'),
      length: lengthStr == null ? null : int.tryParse(lengthStr),
      bitrate: bitrateStr == null ? null : int.tryParse(bitrateStr),
      height: heightStr == null ? null : int.tryParse(heightStr),
      lang: element.getAttribute('lang'),
      title: element.getAttribute('title'),
      rel: element.getAttribute('rel'),
      codecs: element.getAttribute('codecs'),
      default_: element.getAttribute('default'),
      sources: element
          .findElements('podcast:source')
          .map((e) => Source.parse(e))
          .toList(),
      integrities: element
          .findElements('podcast:integrity')
          .map((e) => Integrity.parse(e))
          .toList(),
    );
  }
}
