import 'package:xml/xml/nodes/element.dart';

final _imagesRegExp = new RegExp(
  "<img\\s.*?src=(?:'|\")([^'\">]+)(?:'|\")",
  multiLine: true,
  caseSensitive: false,
);

/// For RSS Content Module:
///
/// - `xmlns:content="http://purl.org/rss/1.0/modules/content/"`
///
class RssContent {
  String value;
  Iterable<String> images;

  RssContent(this.value, this.images);

  factory RssContent.parse(XmlElement node) {
    final content = node.text;
    final images = <String>[];
    _imagesRegExp.allMatches(content).forEach((match) {
      images.add(match.group(1));
    });
    return new RssContent(content, images);
  }

  @override
  String toString() {
    return '''
      content: $value
      images: $images
    ''';
  }
}
