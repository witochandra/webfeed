import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#transcript
class Transcript {
  final String? url;
  final String? type;
  final String? language;
  final String? rel;

  Transcript({
    this.url,
    this.type,
    this.language,
    this.rel,
  });

  factory Transcript.parse(XmlElement element) {
    return Transcript(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
      language: element.getAttribute('language'),
      rel: element.getAttribute('rel'),
    );
  }
}
