import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#location
class Location {
  final String? geo;
  final String? osm;
  final String? value;

  Location({
    this.geo,
    this.osm,
    this.value,
  });

  factory Location.parse(XmlElement element) {
    return Location(
      geo: element.getAttribute('geo'),
      osm: element.getAttribute('osm'),
      value: element.text,
    );
  }
}
