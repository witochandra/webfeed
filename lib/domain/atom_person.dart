import 'package:xml/xml.dart';
import 'package:webfeed/util/helpers.dart';

class AtomPerson {
  String name;
  String uri;
  String email;

  AtomPerson(this.name, this.uri, this.email);

  factory AtomPerson.parse(XmlElement element) {
    var name = xmlGetString(element, "name");
    var uri = xmlGetString(element, "uri", strict: false);
    var email = xmlGetString(element, "email", strict: false);
    return new AtomPerson(name, uri, email);
  }
}