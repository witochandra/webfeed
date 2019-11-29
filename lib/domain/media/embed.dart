import 'package:webfeed/domain/media/param.dart';
import 'package:xml/xml.dart';

class Embed {
  final Uri url;
  final int width;
  final int height;
  final List<Param> params;

  Embed({
    this.url,
    this.width,
    this.height,
    this.params,
  });

  factory Embed.parse(XmlElement element) {
    if (element == null) return null;
    var url = element.getAttribute("url");
    return Embed(
      url: url == null ? null : Uri.parse(url),
      width: int.tryParse(element.getAttribute("width") ?? "0"),
      height: int.tryParse(element.getAttribute("height") ?? "0"),
      params: element.findElements("media:param").map((e) => Param.parse(e)).toList(),
    );
  }
}
