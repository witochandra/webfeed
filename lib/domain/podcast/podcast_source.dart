import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#source
class Source {
  final String? url;
  final String? contentType;

  Source({
    this.url,
    this.contentType,
  });

  factory Source.parse(XmlElement element) {
    return Source(
      url: element.getAttribute('url'),
      contentType: element.getAttribute('contentType'),
    );
  }
}
