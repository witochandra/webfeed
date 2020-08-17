import 'package:webfeed/domain/media/category.dart';
import 'package:webfeed/domain/media/community.dart';
import 'package:webfeed/domain/media/content.dart';
import 'package:webfeed/domain/media/copyright.dart';
import 'package:webfeed/domain/media/credit.dart';
import 'package:webfeed/domain/media/description.dart';
import 'package:webfeed/domain/media/embed.dart';
import 'package:webfeed/domain/media/group.dart';
import 'package:webfeed/domain/media/hash.dart';
import 'package:webfeed/domain/media/license.dart';
import 'package:webfeed/domain/media/peer_link.dart';
import 'package:webfeed/domain/media/player.dart';
import 'package:webfeed/domain/media/price.dart';
import 'package:webfeed/domain/media/rating.dart';
import 'package:webfeed/domain/media/restriction.dart';
import 'package:webfeed/domain/media/rights.dart';
import 'package:webfeed/domain/media/scene.dart';
import 'package:webfeed/domain/media/status.dart';
import 'package:webfeed/domain/media/text.dart';
import 'package:webfeed/domain/media/thumbnail.dart';
import 'package:webfeed/domain/media/title.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

class Media {
  final Group group;
  final List<Content> contents;
  final List<Credit> credits;
  final Category category;
  final Rating rating;
  final Title title;
  final Description description;
  final String keywords;
  final List<Thumbnail> thumbnails;
  final Hash hash;
  final Player player;
  final Copyright copyright;
  final Text text;
  final Restriction restriction;
  final Community community;
  final List<String> comments;
  final Embed embed;
  final List<String> responses;
  final List<String> backLinks;
  final Status status;
  final List<Price> prices;
  final License license;
  final PeerLink peerLink;
  final Rights rights;
  final List<Scene> scenes;

  Media({
    this.group,
    this.contents,
    this.credits,
    this.category,
    this.rating,
    this.title,
    this.description,
    this.keywords,
    this.thumbnails,
    this.hash,
    this.player,
    this.copyright,
    this.text,
    this.restriction,
    this.community,
    this.comments,
    this.embed,
    this.responses,
    this.backLinks,
    this.status,
    this.prices,
    this.license,
    this.peerLink,
    this.rights,
    this.scenes,
  });

  factory Media.parse(XmlElement element) {
    return Media(
      group: Group.parse(
        findFirstElement(element, 'media:group'),
      ),
      contents: element.findElements('media:content').map((e) {
        return Content.parse(e);
      }).toList(),
      credits: element.findElements('media:credit').map((e) {
        return Credit.parse(e);
      }).toList(),
      category: Category.parse(
        findFirstElement(element, 'media:category'),
      ),
      rating: Rating.parse(
        findFirstElement(element, 'media:rating'),
      ),
      title: Title.parse(
        findFirstElement(element, 'media:title'),
      ),
      description: Description.parse(
        findFirstElement(element, 'media:description'),
      ),
      keywords: findFirstElement(element, 'media:keywords')?.text,
      thumbnails: element.findElements('media:thumbnail').map((e) {
        return Thumbnail.parse(e);
      }).toList(),
      hash: Hash.parse(
        findFirstElement(element, 'media:hash'),
      ),
      player: Player.parse(
        findFirstElement(element, 'media:player'),
      ),
      copyright: Copyright.parse(
        findFirstElement(element, 'media:copyright'),
      ),
      text: Text.parse(
        findFirstElement(element, 'media:text'),
      ),
      restriction: Restriction.parse(
        findFirstElement(element, 'media:restriction'),
      ),
      community: Community.parse(
        findFirstElement(element, 'media:community'),
      ),
      comments: findFirstElement(element, 'media:comments')
              ?.findElements('media:comment')
              ?.map((e) {
            return e.text;
          })?.toList() ??
          [],
      embed: Embed.parse(
        findFirstElement(element, 'media:embed'),
      ),
      responses: findFirstElement(element, 'media:responses')
              ?.findElements('media:response')
              ?.map((e) {
            return e.text;
          })?.toList() ??
          [],
      backLinks: findFirstElement(element, 'media:backLinks')
              ?.findElements('media:backLink')
              ?.map((e) {
            return e.text;
          })?.toList() ??
          [],
      status: Status.parse(
        findFirstElement(element, 'media:status'),
      ),
      prices: element.findElements('media:price').map((e) {
        return Price.parse(e);
      }).toList(),
      license: License.parse(
        findFirstElement(element, 'media:license'),
      ),
      peerLink: PeerLink.parse(
        findFirstElement(element, 'media:peerLink'),
      ),
      rights: Rights.parse(
        findFirstElement(element, 'media:rights'),
      ),
      scenes: findFirstElement(element, 'media:scenes')
              ?.findElements('media:scene')
              ?.map((e) {
            return Scene.parse(e);
          })?.toList() ??
          [],
    );
  }
}
