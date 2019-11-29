import 'package:xml/xml.dart';

class Thumbnail {
  final Uri url;
  final String width;
  final String height;
  final String time;

  Thumbnail({
    this.url,
    this.width,
    this.height,
    this.time,
  });

  factory Thumbnail.parse(XmlElement element) {
    var url = element.getAttribute("url");
    return Thumbnail(
      url: url == null ? null : Uri.parse(url),
      width: element.getAttribute("width"),
      height: element.getAttribute("height"),
      time: element.getAttribute("time"),
    );
  }
}
