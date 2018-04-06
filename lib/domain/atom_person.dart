import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

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

  @override
  String toString() {
    return '''
      name: $name
      uri: $uri
      email: $email
    ''';
  }
}
