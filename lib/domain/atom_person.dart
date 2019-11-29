import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomPerson {
  final String name;
  final Uri uri;
  final String email;

  AtomPerson({this.name, this.uri, this.email});

  factory AtomPerson.parse(XmlElement element) {
    var uri = findElementOrNull(element, "uri");
    return AtomPerson(
      name: findElementOrNull(element, "name")?.text,
      uri: uri == null ? null : Uri.parse(uri.text),
      email: findElementOrNull(element, "email")?.text,
    );
  }
}
