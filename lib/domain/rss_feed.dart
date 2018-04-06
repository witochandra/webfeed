import 'dart:core';

import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_cloud.dart';
import 'package:webfeed/domain/rss_image.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class RssFeed {
  final String title;
  final String description;
  final String link;
  final List<RssItem> items;

  final RssImage image;
  final RssCloud cloud;
  final List<RssCategory> categories;
  final List<String> skipDays;
  final List<int> skipHours;
  final String lastBuildDate;
  final String language;
  final String generator;
  final String copyright;
  final String docs;
  final String managingEditor;
  final String rating;
  final String webMaster;
  final int ttl;

  RssFeed(this.title, this.description, this.link, this.items,
      {this.image,
      this.cloud,
      this.categories,
      this.skipDays,
      this.skipHours,
      this.lastBuildDate,
      this.language,
      this.generator,
      this.copyright,
      this.docs,
      this.managingEditor,
      this.rating,
      this.webMaster,
      this.ttl});

  factory RssFeed.parse(String xmlString) {
    var document = parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements("channel").first;
    } on StateError {
      throw new ArgumentError("channel not found");
    }
    var title = xmlGetString(channelElement, "title");
    var description = xmlGetString(channelElement, "description");
    var link = xmlGetString(channelElement, "link");

    var feeds = channelElement.findElements("item").map((element) {
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

    var categories = channelElement.findElements("category").map((element) {
      return new RssCategory.parse(element);
    }).toList();

    var skipDays = new List<String>();
    var skipDaysNodes = channelElement.findElements("skipDays");
    if (skipDaysNodes.isNotEmpty) {
      skipDays = skipDaysNodes.first.findAllElements("day").map((element) {
        return element.text;
      }).toList();
    }
    var skipHours = new List<int>();
    var skipHoursNodes = channelElement.findElements("skipHours");
    if (skipHoursNodes.isNotEmpty) {
      skipHours = skipHoursNodes.first.findAllElements("hour").map((element) {
        try {
          return int.parse(element.text);
        } on FormatException {
          return null;
        }
      }).toList();
    }

    var lastBuildDate = xmlGetString(channelElement, "lastBuildDate", strict: false);
    var language = xmlGetString(channelElement, "language", strict: false);
    var generator = xmlGetString(channelElement, "generator", strict: false);
    var copyright = xmlGetString(channelElement, "copyright", strict: false);
    var docs = xmlGetString(channelElement, "docs", strict: false);
    var managingEditor = xmlGetString(channelElement, "managingEditor", strict: false);
    var rating = xmlGetString(channelElement, "rating", strict: false);
    var webMaster = xmlGetString(channelElement, "webMaster", strict: false);
    var ttl = xmlGetInt(channelElement, "ttl", strict: false);

    return new RssFeed(title, description, link, feeds,
        image: image,
        cloud: cloud,
        categories: categories,
        skipDays: skipDays,
        skipHours: skipHours,
        lastBuildDate: lastBuildDate,
        language: language,
        generator: generator,
        copyright: copyright,
        docs: docs,
        managingEditor: managingEditor,
        rating: rating,
        webMaster: webMaster,
        ttl: ttl);
  }

  @override
  String toString() {
    return '''
      title: $title
      description: $description
      link: $link
      items: $items
      image: $image
      cloud: $cloud
      categories: $categories
      skipDays: $skipDays
      skipHours: $skipHours
      lastBuildDate: $lastBuildDate
      language: $language
      generator: $generator
      copyright: $copyright
      docs: $docs
      managingEditor: $managingEditor
      rating: $rating
      webMaster: $webMaster
      ttl: $ttl
    ''';
  }
}
