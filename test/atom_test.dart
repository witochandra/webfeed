import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/webfeed.dart';

void main() {
  test("parse Invalid.xml", () {
    var xmlString = new File("test/xml/Invalid.xml").readAsStringSync();

    try {
      new AtomFeed.parse(xmlString);
      fail("Should throw Argument Error");
    } on ArgumentError {}
  });

  test("parse Atom.xml", () {
    var xmlString = new File("test/xml/Atom.xml").readAsStringSync();

    var feed = new AtomFeed.parse(xmlString);

    expect(feed.id, "foo-bar-id");
    expect(feed.title, "Foo bar news");
    expect(feed.updated, "2018-04-06T13:02:46Z");

    expect(feed.links.length, 2);
    expect(feed.links.first.rel, "foo");
    expect(feed.links.first.type, "text/html");
    expect(feed.links.first.hreflang, "en");
    expect(feed.links.first.href, "http://foo.bar.news/");
    expect(feed.links.first.title, "Foo bar news html");
    expect(feed.links.first.length, 1000);

    expect(feed.authors.length, 2);
    expect(feed.authors.first.name, "Alice");
    expect(feed.authors.first.uri, "http://foo.bar.news/people/alice");
    expect(feed.authors.first.email, "alice@foo.bar.news");

    expect(feed.contributors.length, 2);
    expect(feed.contributors.first.name, "Charlie");
    expect(feed.contributors.first.uri, "http://foo.bar.news/people/charlie");
    expect(feed.contributors.first.email, "charlie@foo.bar.news");

    expect(feed.categories.length, 2);
    expect(feed.categories.first.term, "foo category");
    expect(feed.categories.first.scheme, "this-is-foo-scheme");
    expect(feed.categories.first.label, "this is foo label");

    expect(feed.generator.uri, "http://foo.bar.news/generator");
    expect(feed.generator.version, "1.0");
    expect(feed.generator.value, "Foo bar generator");

    expect(feed.icon, "http://foo.bar.news/icon.png");
    expect(feed.logo, "http://foo.bar.news/logo.png");
    expect(feed.subtitle, "This is subtitle");

    expect(feed.items.length, 2);
    var item = feed.items.first;
    expect(item.id, "foo-bar-entry-id-1");
    expect(item.title, "Foo bar item 1");
    expect(item.updated, "2018-04-06T13:02:47Z");

    expect(item.authors.length, 2);
    expect(item.authors.first.name, "Ellie");
    expect(item.authors.first.uri, "http://foo.bar.news/people/ellie");
    expect(item.authors.first.email, "ellie@foo.bar.news");

    expect(item.links.length, 2);
    expect(item.links.first.rel, "foo entry");
    expect(item.links.first.type, "text/html");
    expect(item.links.first.hreflang, "en");
    expect(item.links.first.href, "http://foo.bar.news/entry");
    expect(item.links.first.title, "Foo bar news html");
    expect(item.links.first.length, 1000);

    expect(item.categories.length, 2);
    expect(item.categories.first.term, "foo entry category");
    expect(item.categories.first.scheme, "this-is-foo-entry-scheme");
    expect(item.categories.first.label, "this is foo entry label");

    expect(item.contributors.length, 2);
    expect(item.contributors.first.name, "Gin");
    expect(item.contributors.first.uri, "http://foo.bar.news/people/gin");
    expect(item.contributors.first.email, "gin@foo.bar.news");

    expect(item.published, "2018-04-06T13:02:49Z");
    expect(item.summary, "This is summary 1");
    expect(item.content, "This is content 1");
    expect(item.rights, "This is rights 1");
  });
  test("parse Atom-Media.xml", (){
    var xmlString = new File("test/xml/Atom-Media.xml").readAsStringSync();

    var feed = new AtomFeed.parse(xmlString);
    expect(feed.id, "foo-bar-id");
    expect(feed.title, "Foo bar news");
    expect(feed.updated, "2018-04-06T13:02:46Z");

    expect(feed.items.length, 1);
    
    var item = feed.items.first;
    expect(item.media.group.contents.length, 5);
    expect(item.media.group.credits.length, 2);
    expect(item.media.group.category.value, "music/artist name/album/song");
    expect(item.media.group.rating.value, "nonadult");

    expect(item.media.contents.length, 2);
    var mediaContent = item.media.contents.first;
    expect(mediaContent.url, "http://www.foo.com/video.mov");
    expect(mediaContent.type, "video/quicktime");
    expect(mediaContent.fileSize, 2000);
    expect(mediaContent.medium, "video");
    expect(mediaContent.isDefault, true);
    expect(mediaContent.expression, "full");
    expect(mediaContent.bitrate, 128);
    expect(mediaContent.framerate, 25);
    expect(mediaContent.samplingrate, 44.1);
    expect(mediaContent.channels, 2);

    expect(item.media.credits.length, 2);
    var mediaCredit = item.media.credits.first;
    expect(mediaCredit.role, "owner1");
    expect(mediaCredit.scheme, "urn:yvs");
    expect(mediaCredit.value, "copyright holder of the entity");

    expect(item.media.category.scheme, "http://search.yahoo.com/mrss/category_ schema");
    expect(item.media.category.label, "Music");
    expect(item.media.category.value, "music/artist/album/song");

    expect(item.media.rating.scheme, "urn:simple");
    expect(item.media.rating.value, "adult");

    expect(item.media.title.type, "plain");
    expect(item.media.title.value, "The Judy's -- The Moo Song");

    expect(item.media.description.type, "plain");
    expect(item.media.description.value, "This was some really bizarre band I listened to as a young lad.");
    
    expect(item.media.keywords, "kitty, cat, big dog, yarn, fluffy");
  
    expect(item.media.thumbnails.length, 2);
    var mediaThumbnail = item.media.thumbnails.first;
    expect(mediaThumbnail.url, "http://www.foo.com/keyframe1.jpg");
    expect(mediaThumbnail.width, "75");
    expect(mediaThumbnail.height, "50");
    expect(mediaThumbnail.time, "12:05:01.123");

    expect(item.media.hash.algo, "md5");
    expect(item.media.hash.value, "dfdec888b72151965a34b4b59031290a");

    expect(item.media.player.url, "http://www.foo.com/player?id=1111");
    expect(item.media.player.width, 400);
    expect(item.media.player.height, 200);
    expect(item.media.player.value, "");

    expect(item.media.copyright.url, "http://blah.com/additional-info.html");
    expect(item.media.copyright.value, "2005 FooBar Media");

    expect(item.media.text.type, "plain");
    expect(item.media.text.lang, "en");
    expect(item.media.text.start, "00:00:03.000");
    expect(item.media.text.end, "00:00:10.000");
    expect(item.media.text.value, " Oh, say, can you see");

    expect(item.media.restriction.relationship, "allow");
    expect(item.media.restriction.type, "country");
    expect(item.media.restriction.value, "au us");

    expect(item.media.community.starRating.average, 3.5);
    expect(item.media.community.starRating.count, 20);
    expect(item.media.community.starRating.min, 1);
    expect(item.media.community.starRating.max, 10);
    expect(item.media.community.statistics.views, 5);
    expect(item.media.community.statistics.favorites, 4);
    expect(item.media.community.tags.tags, "news: 5, abc:3");
    expect(item.media.community.tags.weight, 1);

    expect(item.media.comments.length, 2);
    expect(item.media.comments.first, "comment1");
    expect(item.media.comments.last, "comment2");

    expect(item.media.embed.url, "http://www.foo.com/player.swf");
    expect(item.media.embed.width, 512);
    expect(item.media.embed.height, 323);
    expect(item.media.embed.params.length, 5);
    expect(item.media.embed.params.first.name, "type");
    expect(item.media.embed.params.first.value, "application/x-shockwave-flash");

    expect(item.media.responses.length, 2);
    expect(item.media.responses.first, "http://www.response1.com");
    expect(item.media.responses.last, "http://www.response2.com");

    expect(item.media.backLinks.length, 2);
    expect(item.media.backLinks.first, "http://www.backlink1.com");
    expect(item.media.backLinks.last, "http://www.backlink2.com");

    expect(item.media.status.state, "active");
    expect(item.media.status.reason, null);

    expect(item.media.prices.length, 2);
    expect(item.media.prices.first.price, 19.99);
    expect(item.media.prices.first.type, "rent");
    expect(item.media.prices.first.info, "http://www.dummy.jp/package_info.html");
    expect(item.media.prices.first.currency, "EUR");

    expect(item.media.license.type, "text/html");
    expect(item.media.license.href, "http://www.licensehost.com/license");
    expect(item.media.license.value, " Sample license for a video");

    expect(item.media.peerLink.type, "application/x-bittorrent");
    expect(item.media.peerLink.href, "http://www.foo.org/sampleFile.torrent");
    expect(item.media.peerLink.value, "");

    expect(item.media.rights.status, "official");

    expect(item.media.scenes.length, 2);
    expect(item.media.scenes.first.title, "sceneTitle1");
    expect(item.media.scenes.first.description, "sceneDesc1");
    expect(item.media.scenes.first.startTime, "00:15");
    expect(item.media.scenes.first.endTime, "00:45");
  });

  test("parse Atom-Empty.xml", () {
    var xmlString = File("test/xml/Atom-Empty.xml").readAsStringSync();

    var feed = AtomFeed.parse(xmlString);

    expect(feed.id, null);
    expect(feed.title, null);
    expect(feed.updated, null);
    expect(feed.links.length, 0);
    expect(feed.authors.length, 0);
    expect(feed.contributors.length, 0);
    expect(feed.categories.length, 0);
    expect(feed.generator, null);
    expect(feed.icon, null);
    expect(feed.logo, null);
    expect(feed.subtitle, null);

    expect(feed.items.length, 1);
    var item = feed.items.first;

    expect(item.authors.length, 0);

    expect(item.links.length, 0);

    expect(item.categories.length, 0);

    expect(item.contributors.length, 0);

    expect(item.published, null);
    expect(item.summary, null);
    expect(item.content, null);
    expect(item.rights, null);
  });
}
