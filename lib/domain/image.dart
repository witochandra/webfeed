import 'package:webfeedclient/util/helpers.dart';
import 'package:xml/xml.dart';

class Image {
  final String title;
  final String url;
  final String link;

  Image(this.title, this.url, this.link);

  factory Image.parse(XmlElement element) {
    var title = xmlGetString(element, "title", strict: false);
    var url = xmlGetString(element, "url", strict: false);
    var link = xmlGetString(element, "link", strict: false);

    return new Image(title, url, link);
  }

  @override
  String toString() {
    return '''
      title: $title
      url: $url
      link: $link
    ''';
  }
}
