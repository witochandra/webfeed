import 'dart:core';

import 'package:webfeed/domain/dublin_core/dublin_core.dart';
import 'package:webfeed/domain/rss1_item.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

enum UpdatePeriod {
  Hourly,
  Daily,
  Weekly,
  Monthly,
  Yearly,
}

class Rss1Feed {
  final String title;
  final String description;
  final String link;
  final String image;
  final List<Rss1Item> items;
  final UpdatePeriod updatePeriod;
  final int updateFrequency;
  final DateTime updateBase;
  final DublinCore dc;

  Rss1Feed({
    this.title,
    this.description,
    this.link,
    this.items,
    this.image,
    this.updatePeriod,
    this.updateFrequency,
    this.updateBase,
    this.dc,
  });

  static UpdatePeriod _parseUpdatePeriod(String updatePeriodString) {
    switch (updatePeriodString) {
      case 'hourly':
        return UpdatePeriod.Hourly;
      case 'daily':
        return UpdatePeriod.Daily;
      case 'weekly':
        return UpdatePeriod.Weekly;
      case 'monthly':
        return UpdatePeriod.Monthly;
      case 'yearly':
        return UpdatePeriod.Yearly;
      default:
        return null;
    }
  }

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
      updatePeriod: _parseUpdatePeriod(
          findElementOrNull(rdfElement, 'sy:updatePeriod')?.text),
      updateFrequency:
          parseInt(findElementOrNull(rdfElement, 'sy:updateFrequency')?.text),
      updateBase:
          parseDateTime(findElementOrNull(rdfElement, 'sy:updateBase')?.text),
      dc: DublinCore.parse(rdfElement.findElements('channel').first),
    );
  }
}
