import 'package:xml/xml.dart';

class Player {
  final Uri url;
  final int width;
  final int height;
  final String value;

  Player({
    this.url,
    this.width,
    this.height,
    this.value,
  });

  factory Player.parse(XmlElement element) {
    if (element == null) return null;
    var url = element.getAttribute("url");
    return Player(
      url: url == null ? null : Uri.parse(url),
      width: int.tryParse(element.getAttribute("width") ?? "0"),
      height: int.tryParse(element.getAttribute("height") ?? "0"),
      value: element.text,
    );
  }
}
