import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class RssImage {
  final String title;
  final String url;
  final String link;

  RssImage({this.title, this.url, this.link});

  factory RssImage.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    return RssImage(
      title: findFirstElement(element, 'title')?.text,
      url: findFirstElement(element, 'url')?.text,
      link: findFirstElement(element, 'link')?.text,
    );
  }
}
