import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#episode
class Episode {
  final String? display;
  final double? value;

  Episode({
    this.display,
    this.value,
  });

  factory Episode.parse(XmlElement element) {
    return Episode(
      display: element.getAttribute('display'),
      value: double.tryParse(element.text),
    );
  }
}
