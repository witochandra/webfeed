import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#chapters
class Chapters {
  final String? url;
  final String? type;

  Chapters({
    this.url,
    this.type,
  });

  factory Chapters.parse(XmlElement element) {
    return Chapters(
      url: element.getAttribute('url'),
      type: element.getAttribute('type'),
    );
  }
}
