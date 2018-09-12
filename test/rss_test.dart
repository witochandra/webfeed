import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/webfeed.dart';

void main() {
  test("parse Invalid.xml", () {
    var xmlString = new File("test/xml/Invalid.xml").readAsStringSync();

    try {
      new RssFeed.parse(xmlString);
      fail("Should throw Argument Error");
    } on ArgumentError {}
  });
  test("parse RSS.xml", () {
    var xmlString = new File("test/xml/RSS.xml").readAsStringSync();

    var feed = new RssFeed.parse(xmlString);

    expect(feed.title, "News - Foo bar News");
    expect(feed.description, "Foo bar News and Updates feed provided by Foo bar, Inc.");
    expect(feed.link, "https://foo.bar.news/");
    expect(feed.language, "en-US");
    expect(feed.lastBuildDate, "Mon, 26 Mar 2018 14:00:00 PDT");
    expect(feed.generator, "Custom");
    expect(feed.copyright, "Copyright 2018, Foo bar Inc.");
    expect(feed.docs, "https://foo.bar.news/docs");
    expect(feed.managingEditor, "alice@foo.bar.news");
    expect(feed.rating, "The PICS rating of the feed");
    expect(feed.webMaster, "webmaster@foo.bar.news");
    expect(feed.ttl, 60);

    expect(feed.image.title, "Foo bar News");
    expect(feed.image.url, "https://foo.bar.news/logo.gif");
    expect(feed.image.link, "https://foo.bar.news/");

    expect(feed.cloud.domain, "radio.foo.bar.news");
    expect(feed.cloud.port, "80");
    expect(feed.cloud.path, "/RPC2");
    expect(feed.cloud.registerProcedure, "foo.bar.rssPleaseNotify");
    expect(feed.cloud.protocol, "xml-rpc");

    expect(feed.categories.length, 2);
    expect(feed.categories[0].domain, null);
    expect(feed.categories[0].value, "Ipsum");
    expect(feed.categories[1].domain, "news");
    expect(feed.categories[1].value, "Lorem Ipsum");

    expect(feed.skipDays.length, 3);
    expect(feed.skipDays.contains("Monday"), true);
    expect(feed.skipDays.contains("Tuesday"), true);
    expect(feed.skipDays.contains("Sunday"), true);

    expect(feed.skipHours.length, 5);
    expect(feed.skipHours.contains(0), true);
    expect(feed.skipHours.contains(1), true);
    expect(feed.skipHours.contains(2), true);
    expect(feed.skipHours.contains(3), true);
    expect(feed.skipHours.contains(4), true);

    expect(feed.items.length, 2);

    expect(feed.items.first.title, "The standard Lorem Ipsum passage, used since the 1500s");
    expect(feed.items.first.description, "Lorem ipsum dolor sit amet, consectetur adipiscing elit");
    expect(feed.items.first.link, "https://foo.bar.news/1");
    expect(feed.items.first.guid, "https://foo.bar.news/1?guid");
    expect(feed.items.first.pubDate, "Mon, 26 Mar 2018 14:00:00 PDT");
    expect(feed.items.first.categories.first.domain, "news");
    expect(feed.items.first.categories.first.value, "Lorem");
    expect(feed.items.first.author, "alice@foo.bar.news");
    expect(feed.items.first.source.url, "https://foo.bar.news/1?source");
    expect(feed.items.first.source.value, "Foo Bar");
    expect(feed.items.first.comments, "https://foo.bar.news/1/comments");

    expect(feed.items.first.content.value, "<img width=\"1000\" height=\"690\" src=\"https://test.com/image_link\"/> Test content<br />");
    expect(feed.items.first.content.images.first, "https://test.com/image_link");
  });
  test("parse RSS-Media.xml", (){
    var xmlString = new File("test/xml/RSS-Media.xml").readAsStringSync();

    var feed = new RssFeed.parse(xmlString);
    expect(feed.title, "Song Site");
    expect(feed.description, "Media RSS example with new fields added in v1.5.0");

    expect(feed.items.length, 1);
    
    var item = feed.items.first;
    expect(item.title, null);
    expect(item.link, "http://www.foo.com");
    expect(item.pubDate, "Mon, 27 Aug 2001 16:08:56 PST");

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
}
