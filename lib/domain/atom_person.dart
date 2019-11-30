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

  void build(XmlBuilder b, String type) {
    b.element(type, nest: () {
      if (name != null) b.element('name', nest: () => b.text(name));
      if (uri != null) b.element('uri', nest: () => b.text(uri));
      if (email != null) b.element('email', nest: () => b.text(email));
    });
  }
}
