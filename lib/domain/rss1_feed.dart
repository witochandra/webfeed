import 'dart:core';

import 'package:webfeed/domain/rss1_item.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class Rss1Feed {
  final String title;
  final String description;
  final String link;
  final String image;
  final List<Rss1Item> items;

  Rss1Feed({
    this.title,
    this.description,
    this.link,
    this.items,
    this.image,
  });

  factory Rss1Feed.parse(String xmlString) {
    var document = parse(xmlString);
    XmlElement rdfElement;
    try {
      rdfElement = document.findAllElements("rdf:RDF").first;
    } on StateError {
      throw ArgumentError("channel not found");
    }

    return Rss1Feed(
      title: findElementOrNull(rdfElement, "title")?.text,
      link: findElementOrNull(rdfElement, "link")?.text,
      description: findElementOrNull(rdfElement, "description")?.text,
      items: rdfElement.findElements("item").map((element) {
        return Rss1Item.parse(element);
      }).toList(),
      image:
          findElementOrNull(rdfElement, 'image')?.getAttribute('rdf:resource'),
    );
  }
}
