import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#person
class Person {
  final String? role;
  final String? group;
  final String? img;
  final String? href;
  final String? value;

  Person({
    this.role,
    this.group,
    this.img,
    this.href,
    this.value,
  });

  factory Person.parse(XmlElement element) {
    return Person(
      role: element.getAttribute('role'),
      group: element.getAttribute('group'),
      img: element.getAttribute('img'),
      href: element.getAttribute('href'),
      value: element.text,
    );
  }
}
