import 'dart:core';

import 'package:webfeedclient/domain/item.dart';
import 'package:webfeedclient/util/helpers.dart';
import 'package:xml/xml.dart';

import 'image.dart';

class Channel {
  final String title;
  final String description;
  final String link;
  final List<Item> items;

  final Image image;
  final String lastBuildDate;
  final String language;
  final String generator;
  final String copyright;

  Channel(this.title, this.description, this.link, this.items,
      {this.image, this.lastBuildDate, this.language, this.generator, this.copyright});

  factory Channel.parse(XmlDocument document) {
    XmlElement channelElement;
    try {
      channelElement = document
          .findAllElements("channel")
          .first;
    } on StateError {
      throw new ArgumentError("channel not found");
    }
    var title = xmlGetString(channelElement, "title");
    var description = xmlGetString(channelElement, "description");
    var link = xmlGetString(channelElement, "link");

    var feeds = channelElement.findAllElements("item").map((XmlElement element) {
      return new Item.parse(element);
    }).toList();

    Image image;
    try {
      image = new Image.parse(channelElement
          .findElements("image")
          .first);
    } on StateError {}

    var lastBuildDate = xmlGetString(channelElement, "lastBuildDate", strict: false);
    var language = xmlGetString(channelElement, "language", strict: false);
    var generator = xmlGetString(channelElement, "generator", strict: false);
    var copyright = xmlGetString(channelElement, "copyright", strict: false);

    return new Channel(title, description, link, feeds, image: image,
        lastBuildDate: lastBuildDate,
        language: language,
        generator: generator,
        copyright: copyright);
  }

  @override
  String toString() {
    return '''
      title: $title
      description: $description
      link: $link
      lastBuildDate: $lastBuildDate
      items: $items
    ''';
  }
}
