import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class AtomPerson {
  final String name;
  final String uri;
  final String email;

  AtomPerson({this.name, this.uri, this.email});

  factory AtomPerson.parse(XmlElement element) {
    return AtomPerson(
      name: findFirstElement(element, 'name')?.text,
      uri: findFirstElement(element, 'uri')?.text,
      email: findFirstElement(element, 'email')?.text,
    );
  }
}
