import 'package:webfeed/domain/media/category.dart';
import 'package:webfeed/domain/media/content.dart';
import 'package:webfeed/domain/media/credit.dart';
import 'package:webfeed/domain/media/description.dart';
import 'package:webfeed/domain/media/rating.dart';
import 'package:webfeed/domain/media/thumbnail.dart';
import 'package:webfeed/domain/media/title.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content>? contents;
  final List<Credit>? credits;
  final Category? category;
  final Rating? rating;
  final Thumbnail? thumbnail;
  final Title? title;
  final Description? description;

  Group({
    this.contents,
    this.credits,
    this.category,
    this.rating,
    this.thumbnail,
    this.title,
    this.description,
  });

  factory Group.parse(XmlElement element) {
    return Group(
      contents: element
          .findElements('media:content')
          .map((e) => Content.parse(e))
          .toList(),
      credits: element
          .findElements('media:credit')
          .map((e) => Credit.parse(e))
          .toList(),
      category: element
          .findElements('media:category')
          .map((e) => Category.parse(e))
          .firstOrNull,
      rating: element
          .findElements('media:rating')
          .map((e) => Rating.parse(e))
          .firstOrNull,
      thumbnail: element
          .findElements('media:thumbnail')
          .map((e) => Thumbnail.parse(e))
          .firstOrNull,
      title: element
          .findElements('media:title')
          .map((e) => Title.parse(e))
          .firstOrNull,
      description: element
          .findElements('media:title')
          .map((e) => Description.parse(e))
          .firstOrNull,
    );
  }
}
