import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class Geo {
  final double lat;
  final double long;

  Geo(this.lat, this.long);

  factory Geo.parse(XmlElement element) {
    if (element == null) {
      return null;
    }

    var lat = double.tryParse(findFirstElement(element, 'geo:lat')?.text ?? '');
    var long =
        double.tryParse(findFirstElement(element, 'geo:long')?.text ?? '');

    if (lat == null || long == null) {
      return null;
    } else {
      return Geo(lat, long);
    }
  }
}
