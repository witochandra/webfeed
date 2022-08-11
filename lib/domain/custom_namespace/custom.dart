import 'package:xml/xml.dart';

class CustomNamespace {
  final Map<String, dynamic> customTags;

  CustomNamespace({ required this.customTags });

  String? valueForKey(String key) {
    return customTags[key];
  }

  factory CustomNamespace.parse(XmlElement element) {
    final customTags = <String, dynamic>{};

    element.descendantElements.forEach((descendantElement) {
      customTags.addEntries([
        MapEntry(
          descendantElement.name.toString(),
          descendantElement.text,
        ),
      ]);
    });

    return CustomNamespace(customTags: customTags);
  }
}