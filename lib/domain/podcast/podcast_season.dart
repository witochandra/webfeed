import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#season
class Season {
  final String? name;
  final int? value;

  Season({
    this.name,
    this.value,
  });

  factory Season.parse(XmlElement element) {
    return Season(
      name: element.getAttribute('name'),
      value: int.tryParse(element.text),
    );
  }
}
