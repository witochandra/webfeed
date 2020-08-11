import 'package:xml/xml.dart';

class ItunesCategory {
  final String category;
  final List<String> subCategories;

  ItunesCategory({this.category, this.subCategories});

  factory ItunesCategory.parse(XmlElement element) {
    if (element == null) return null;

    Iterable<XmlElement> subCategories;
    try {
      subCategories = element.findElements('itunes:category');
    } on StateError {
      subCategories = null;
    }
    return ItunesCategory(
      category: element.getAttribute('text')?.trim(),
      subCategories: subCategories
          ?.map((ele) => ele.getAttribute('text')?.trim())
          ?.toList(),
    );
  }
}
