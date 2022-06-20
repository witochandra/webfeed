import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#content-link
class ContentLink {
  final String? href;
  final String? value;

  ContentLink({
    this.href,
    this.value,
  });

  factory ContentLink.parse(XmlElement element) {
    return ContentLink(
      href: element.getAttribute('href'),
      value: element.text,
    );
  }
}
