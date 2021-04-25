import 'package:xml/xml.dart';

class ItunesCategory {
  final String? category;
  final List<String?>? subCategories;

  ItunesCategory({this.category, this.subCategories});

  static ItunesCategory? parse(XmlElement? element) {
    if (element == null) return null;
    return ItunesCategory(
        category: element.getAttribute('text')?.trim(),
        subCategories: element
            .findElements('itunes:category')
            .map((e) => e.getAttribute('text')?.trim())
            .toList());
  }
}
