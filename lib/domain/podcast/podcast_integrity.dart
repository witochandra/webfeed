import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#integrity
class Integrity {
  final String? type;
  final String? value;

  Integrity({
    this.type,
    this.value,
  });

  factory Integrity.parse(XmlElement element) {
    return Integrity(
      type: element.getAttribute('type'),
      value: element.getAttribute('value'),
    );
  }
}
