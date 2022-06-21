import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#guid
class Guid {
  final String? value;

  Guid({
    this.value,
  });

  factory Guid.parse(XmlElement element) {
    return Guid(
      value: element.text,
    );
  }
}
