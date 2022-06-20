import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#funding
class Funding {
  final String? url;
  final String? value;

  Funding({
    this.url,
    this.value,
  });

  factory Funding.parse(XmlElement element) {
    return Funding(
      url: element.getAttribute('url'),
      value: element.text,
    );
  }
}
