import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class ItunesOwner {
  final String name;
  final String email;

  ItunesOwner({this.name, this.email});

  factory ItunesOwner.parse(XmlElement element) {
    if (element == null) return null;
    return ItunesOwner(
      name: findElementOrNull(element, 'itunes:name')?.text?.trim(),
      email: findElementOrNull(element, 'itunes:email')?.text?.trim(),
    );
  }
}
