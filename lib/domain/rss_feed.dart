import 'dart:core';

import 'package:webfeed/domain/dublin_core/dublin_core.dart';
import 'package:webfeed/domain/itunes/itunes.dart';
import 'package:webfeed/domain/rss_category.dart';
import 'package:webfeed/domain/rss_cloud.dart';
import 'package:webfeed/domain/rss_image.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class RssFeed {
  final String title;
  final String author;
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
  final DublinCore dc;
  final Itunes itunes;

  RssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.image,
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
    this.ttl,
    this.dc,
    this.itunes,
  });

  factory RssFeed.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    var rss = findFirstElement(document, 'rss');
    var rdf = findFirstElement(document, 'rdf:RDF');
    if (rss == null && rdf == null) {
      throw ArgumentError('not a rss feed');
    }
    var channelElement = findFirstElement(rss ?? rdf, 'channel');
    if (channelElement == null) {
      throw ArgumentError('channel not found');
    }
    return RssFeed(
      title: findFirstElement(channelElement, 'title')?.text,
      author: findFirstElement(channelElement, 'author')?.text,
      description: findFirstElement(channelElement, 'description')?.text,
      link: findFirstElement(channelElement, 'link')?.text,
      items: (rss != null ? channelElement : rdf)
          .findElements('item')
          .map((e) => RssItem.parse(e))
          .toList(),
      image: RssImage.parse(
          findFirstElement(rss != null ? channelElement : rdf, 'image')),
      cloud: RssCloud.parse(findFirstElement(channelElement, 'cloud')),
      categories: channelElement
          .findElements('category')
          .map((e) => RssCategory.parse(e))
          .toList(),
      skipDays: findFirstElement(channelElement, 'skipDays')
              ?.findAllElements('day')
              ?.map((e) => e.text)
              ?.toList() ??
          [],
      skipHours: findFirstElement(channelElement, 'skipHours')
              ?.findAllElements('hour')
              ?.map((e) => int.tryParse(e.text ?? '0'))
              ?.toList() ??
          [],
      lastBuildDate: findFirstElement(channelElement, 'lastBuildDate')?.text,
      language: findFirstElement(channelElement, 'language')?.text,
      generator: findFirstElement(channelElement, 'generator')?.text,
      copyright: findFirstElement(channelElement, 'copyright')?.text,
      docs: findFirstElement(channelElement, 'docs')?.text,
      managingEditor: findFirstElement(channelElement, 'managingEditor')?.text,
      rating: findFirstElement(channelElement, 'rating')?.text,
      webMaster: findFirstElement(channelElement, 'webMaster')?.text,
      ttl: int.tryParse(findFirstElement(channelElement, 'ttl')?.text ?? '0'),
      dc: DublinCore.parse(channelElement),
      itunes: Itunes.parse(channelElement),
    );
  }
}
