import 'package:webfeed/domain/media/content.dart';
import 'package:xml/xml.dart';

class Media {
  final List<Content> contents;

  Media({this.contents});

  factory Media.parse(XmlElement element) {
    var contents = element.findAllElements("media:content").map((e) {
      return new Content.parse(e);
    }).toList();
    return new Media(
      contents: contents,
    );
  }
}
