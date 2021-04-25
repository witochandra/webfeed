import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class ItunesOwner {
  final String? name;
  final String? email;

  ItunesOwner({this.name, this.email});

  factory ItunesOwner.parse(XmlElement? element) {
    return ItunesOwner(
      name: findFirstElement(element, 'itunes:name')?.text.trim(),
      email: findFirstElement(element, 'itunes:email')?.text.trim(),
    );
  }
}
