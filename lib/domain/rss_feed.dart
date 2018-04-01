import 'dart:core';

import 'package:webfeedclient/domain/rss_category.dart';
import 'package:webfeedclient/domain/rss_cloud.dart';
import 'package:webfeedclient/domain/rss_item.dart';
import 'package:webfeedclient/util/helpers.dart';
import 'package:xml/xml.dart';

import 'package:webfeedclient/domain/rss_image.dart';

class RssFeed {
  final String title;
  final String description;
  final String link;
  final List<RssItem> items;

  final RssImage image;
  final RssCloud cloud;
  final List<RssCategory> categories;
  final String lastBuildDate;
  final String language;
  final String generator;
  final String copyright;

  RssFeed(this.title, this.description, this.link, this.items,
      {this.image, this.cloud, this.categories, this.lastBuildDate, this.language, this.generator, this.copyright});

  factory RssFeed.parse(XmlDocument document) {
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements("channel").first;
    } on StateError {
      throw new ArgumentError("channel not found");
    }
    var title = xmlGetString(channelElement, "title");
    var description = xmlGetString(channelElement, "description");
    var link = xmlGetString(channelElement, "link");

    List<RssItem> feeds = channelElement.findElements("item").map((element) {
      return new RssItem.parse(element);
    }).toList();

    RssImage image;
    try {
      image = new RssImage.parse(channelElement.findElements("image").first);
    } on StateError {}

    RssCloud cloud;
    try {
      cloud = new RssCloud.parse(channelElement.findElements("cloud").first);
    } on StateError {}

    List<RssCategory> categories = channelElement.findElements("category").map((element) {
      return new RssCategory.parse(element);
    }).toList();

    var lastBuildDate = xmlGetString(channelElement, "lastBuildDate", strict: false);
    var language = xmlGetString(channelElement, "language", strict: false);
    var generator = xmlGetString(channelElement, "generator", strict: false);
    var copyright = xmlGetString(channelElement, "copyright", strict: false);

    return new RssFeed(title, description, link, feeds,
        image: image,
        cloud: cloud,
        categories: categories,
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
