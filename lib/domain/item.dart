import 'package:webfeedclient/util/helpers.dart';
import 'package:xml/xml.dart';

class Item {
  final String title;
  final String description;
  final String link;
  final String guid;
  final String pubDate;

  Item(this.title, this.description, this.link, {this.guid, this.pubDate});

  factory Item.parse(XmlElement element) {
    var title = xmlGetString(element, "title");
    var description = xmlGetString(element, "description");
    var link = xmlGetString(element, "link");

    var guid = xmlGetString(element, "guid", strict: false);
    var pubDate = xmlGetString(element, "pubDate", strict: false);

    return new Item(title, description, link, guid: guid, pubDate: pubDate);
  }

  @override
  String toString() {
    return '''
      title: $title
      description: $description
      link: $link
      pubDate: $pubDate
    ''';
  }
}
