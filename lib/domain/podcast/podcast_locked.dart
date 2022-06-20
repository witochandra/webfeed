import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#locked
class Locked {
  final String? owner;
  final bool? value;

  Locked({
    this.owner,
    this.value,
  });

  factory Locked.parse(XmlElement element) {
    bool? valueBool;
    switch (element.text.toLowerCase()) {
      case 'yes':
        valueBool = true;
        break;
      case 'no':
        valueBool = false;
        break;
      default:
        valueBool = null;
        break;
    }
    return Locked(
      owner: element.getAttribute('owner'),
      value: valueBool,
    );
  }
}
