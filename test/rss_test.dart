import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/domain/itunes/itunes_episode_type.dart';
import 'package:webfeed/domain/itunes/itunes_type.dart';
import 'package:webfeed/domain/syndication/syndication.dart';
import 'package:webfeed/webfeed.dart';

void main() {
  test('parse Invalid.xml', () {
    var xmlString = File('test/xml/Invalid.xml').readAsStringSync();

    try {
      RssFeed.parse(xmlString);
      fail('Should throw Argument Error');
    } on ArgumentError {}
  });
  test('parse RSS.xml', () {
    var xmlString = File('test/xml/RSS.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.title, 'News - Foo bar News');
    expect(feed.description,
        'Foo bar News and Updates feed provided by Foo bar, Inc.');
    expect(feed.link, 'https://foo.bar.news/');
    expect(feed.author, 'hello@world.net');
    expect(feed.language, 'en-US');
    expect(feed.lastBuildDate, 'Mon, 26 Mar 2018 14:00:00 PDT');
    expect(feed.generator, 'Custom');
    expect(feed.copyright, 'Copyright 2018, Foo bar Inc.');
    expect(feed.docs, 'https://foo.bar.news/docs');
    expect(feed.managingEditor, 'alice@foo.bar.news');
    expect(feed.rating, 'The PICS rating of the feed');
    expect(feed.webMaster, 'webmaster@foo.bar.news');
    expect(feed.ttl, 60);

    expect(feed.image!.title, 'Foo bar News');
    expect(feed.image!.url, 'https://foo.bar.news/logo.gif');
    expect(feed.image!.link, 'https://foo.bar.news/');

    expect(feed.cloud!.domain, 'radio.foo.bar.news');
    expect(feed.cloud!.port, '80');
    expect(feed.cloud!.path, '/RPC2');
    expect(feed.cloud!.registerProcedure, 'foo.bar.rssPleaseNotify');
    expect(feed.cloud!.protocol, 'xml-rpc');

    expect(feed.categories!.length, 2);
    expect(feed.categories![0].domain, null);
    expect(feed.categories![0].value, 'Ipsum');
    expect(feed.categories![1].domain, 'news');
    expect(feed.categories![1].value, 'Lorem Ipsum');

    expect(feed.skipDays!.length, 3);
    expect(feed.skipDays!.contains('Monday'), true);
    expect(feed.skipDays!.contains('Tuesday'), true);
    expect(feed.skipDays!.contains('Sunday'), true);

    expect(feed.skipHours!.length, 5);
    expect(feed.skipHours!.contains(0), true);
    expect(feed.skipHours!.contains(1), true);
    expect(feed.skipHours!.contains(2), true);
    expect(feed.skipHours!.contains(3), true);
    expect(feed.skipHours!.contains(4), true);

    expect(feed.items!.length, 2);

    expect(feed.items!.first.title,
        'The standard Lorem Ipsum passage, used since the 1500s');
    expect(feed.items!.first.description,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit');
    expect(feed.items!.first.link, 'https://foo.bar.news/1');
    expect(feed.items!.first.guid, 'https://foo.bar.news/1?guid');
    expect(feed.items!.first.pubDate,
        DateTime(2018, 03, 26, 14)); //Mon, 26 Mar 2018 14:00:00 PDT
    expect(feed.items!.first.categories!.first.domain, 'news');
    expect(feed.items!.first.categories!.first.value, 'Lorem');
    expect(feed.items!.first.author, 'alice@foo.bar.news');
    expect(feed.items!.first.source!.url, 'https://foo.bar.news/1?source');
    expect(feed.items!.first.source!.value, 'Foo Bar');
    expect(feed.items!.first.comments, 'https://foo.bar.news/1/comments');
    expect(feed.items!.first.enclosure!.url,
        'http://www.scripting.com/mp3s/weatherReportSuite.mp3');
    expect(feed.items!.first.enclosure!.length, 12216320);
    expect(feed.items!.first.enclosure!.type, 'audio/mpeg');

    expect(feed.items!.first.content!.value,
        '<img width="1000" height="690" src="https://test.com/image_link"/> Test content<br />');
    expect(
        feed.items!.first.content!.images.first, 'https://test.com/image_link');
  });
  test('parse RSS-Media.xml', () {
    var xmlString = File('test/xml/RSS-Media.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);
    expect(feed.title, 'Song Site');
    expect(
        feed.description, 'Media RSS example with new fields added in v1.5.0');

    expect(feed.items!.length, 1);

    var item = feed.items!.first;
    expect(item.title, null);
    expect(item.link, 'http://www.foo.com');
    expect(item.pubDate,
        DateTime(2001, 08, 27, 16, 08, 56)); //Mon, 27 Aug 2001 16:08:56 PST

    expect(item.media!.group!.contents!.length, 5);
    expect(item.media!.group!.credits!.length, 2);
    expect(item.media!.group!.category!.value, 'music/artist name/album/song');
    expect(item.media!.group!.rating!.value, 'nonadult');

    expect(item.media!.contents!.length, 2);
    var mediaContent = item.media!.contents!.first;
    expect(mediaContent.url, 'http://www.foo.com/video.mov');
    expect(mediaContent.type, 'video/quicktime');
    expect(mediaContent.fileSize, 2000);
    expect(mediaContent.medium, 'video');
    expect(mediaContent.isDefault, true);
    expect(mediaContent.expression, 'full');
    expect(mediaContent.bitrate, 128);
    expect(mediaContent.framerate, 25);
    expect(mediaContent.samplingrate, 44.1);
    expect(mediaContent.channels, 2);

    expect(item.media!.credits!.length, 2);
    var mediaCredit = item.media!.credits!.first;
    expect(mediaCredit.role, 'owner1');
    expect(mediaCredit.scheme, 'urn:yvs');
    expect(mediaCredit.value, 'copyright holder of the entity');

    expect(item.media!.category!.scheme,
        'http://search.yahoo.com/mrss/category_ schema');
    expect(item.media!.category!.label, 'Music');
    expect(item.media!.category!.value, 'music/artist/album/song');

    expect(item.media!.rating!.scheme, 'urn:simple');
    expect(item.media!.rating!.value, 'adult');

    expect(item.media!.title!.type, 'plain');
    expect(item.media!.title!.value, "The Judy's -- The Moo Song");

    expect(item.media!.description!.type, 'plain');
    expect(item.media!.description!.value,
        'This was some really bizarre band I listened to as a young lad.');

    expect(item.media!.keywords, 'kitty, cat, big dog, yarn, fluffy');

    expect(item.media!.thumbnails!.length, 2);
    var mediaThumbnail = item.media!.thumbnails!.first;
    expect(mediaThumbnail.url, 'http://www.foo.com/keyframe1.jpg');
    expect(mediaThumbnail.width, '75');
    expect(mediaThumbnail.height, '50');
    expect(mediaThumbnail.time, '12:05:01.123');

    expect(item.media!.hash!.algo, 'md5');
    expect(item.media!.hash!.value, 'dfdec888b72151965a34b4b59031290a');

    expect(item.media!.player!.url, 'http://www.foo.com/player?id=1111');
    expect(item.media!.player!.width, 400);
    expect(item.media!.player!.height, 200);
    expect(item.media!.player!.value, '');

    expect(item.media!.copyright!.url, 'http://blah.com/additional-info.html');
    expect(item.media!.copyright!.value, '2005 FooBar Media');

    expect(item.media!.text!.type, 'plain');
    expect(item.media!.text!.lang, 'en');
    expect(item.media!.text!.start, '00:00:03.000');
    expect(item.media!.text!.end, '00:00:10.000');
    expect(item.media!.text!.value, ' Oh, say, can you see');

    expect(item.media!.restriction!.relationship, 'allow');
    expect(item.media!.restriction!.type, 'country');
    expect(item.media!.restriction!.value, 'au us');

    expect(item.media!.community!.starRating!.average, 3.5);
    expect(item.media!.community!.starRating!.count, 20);
    expect(item.media!.community!.starRating!.min, 1);
    expect(item.media!.community!.starRating!.max, 10);
    expect(item.media!.community!.statistics!.views, 5);
    expect(item.media!.community!.statistics!.favorites, 4);
    expect(item.media!.community!.tags!.tags, 'news: 5, abc:3');
    expect(item.media!.community!.tags!.weight, 1);

    expect(item.media!.comments!.length, 2);
    expect(item.media!.comments!.first, 'comment1');
    expect(item.media!.comments!.last, 'comment2');

    expect(item.media!.embed!.url, 'http://www.foo.com/player.swf');
    expect(item.media!.embed!.width, 512);
    expect(item.media!.embed!.height, 323);
    expect(item.media!.embed!.params!.length, 5);
    expect(item.media!.embed!.params!.first.name, 'type');
    expect(item.media!.embed!.params!.first.value,
        'application/x-shockwave-flash');

    expect(item.media!.responses!.length, 2);
    expect(item.media!.responses!.first, 'http://www.response1.com');
    expect(item.media!.responses!.last, 'http://www.response2.com');

    expect(item.media!.backLinks!.length, 2);
    expect(item.media!.backLinks!.first, 'http://www.backlink1.com');
    expect(item.media!.backLinks!.last, 'http://www.backlink2.com');

    expect(item.media!.status!.state, 'active');
    expect(item.media!.status!.reason, null);

    expect(item.media!.prices!.length, 2);
    expect(item.media!.prices!.first.price, 19.99);
    expect(item.media!.prices!.first.type, 'rent');
    expect(item.media!.prices!.first.info,
        'http://www.dummy.jp/package_info.html');
    expect(item.media!.prices!.first.currency, 'EUR');

    expect(item.media!.license!.type, 'text/html');
    expect(item.media!.license!.href, 'http://www.licensehost.com/license');
    expect(item.media!.license!.value, ' Sample license for a video');

    expect(item.media!.peerLink!.type, 'application/x-bittorrent');
    expect(item.media!.peerLink!.href, 'http://www.foo.org/sampleFile.torrent');
    expect(item.media!.peerLink!.value, '');

    expect(item.media!.rights!.status, 'official');

    expect(item.media!.scenes!.length, 2);
    expect(item.media!.scenes!.first.title, 'sceneTitle1');
    expect(item.media!.scenes!.first.description, 'sceneDesc1');
    expect(item.media!.scenes!.first.startTime, '00:15');
    expect(item.media!.scenes!.first.endTime, '00:45');
  });
  test('parse RSS-DC.xml', () {
    var xmlString = File('test/xml/RSS-DC.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.dc!.title, 'title');
    expect(feed.dc!.creator, 'creator');
    expect(feed.dc!.subject, 'subject');
    expect(feed.dc!.description, 'description');
    expect(feed.dc!.publisher, 'publisher');
    expect(feed.dc!.contributor, 'contributor');
    expect(feed.dc!.date, DateTime.utc(2000, 1, 1, 12));
    expect(feed.dc!.created, DateTime.utc(2000, 1, 1, 13));
    expect(feed.dc!.modified, DateTime.utc(2000, 1, 1, 14));
    expect(feed.dc!.type, 'type');
    expect(feed.dc!.format, 'format');
    expect(feed.dc!.identifier, 'identifier');
    expect(feed.dc!.source, 'source');
    expect(feed.dc!.language, 'language');
    expect(feed.dc!.relation, 'relation');
    expect(feed.dc!.coverage, 'coverage');
    expect(feed.dc!.rights, 'rights');

    expect(feed.items!.first.dc!.title, 'title');
    expect(feed.items!.first.dc!.creator, 'creator');
    expect(feed.items!.first.dc!.subject, 'subject');
    expect(feed.items!.first.dc!.description, 'description');
    expect(feed.items!.first.dc!.publisher, 'publisher');
    expect(feed.items!.first.dc!.contributor, 'contributor');
    expect(feed.items!.first.dc!.date, DateTime.utc(2000, 1, 2, 12));
    expect(feed.items!.first.dc!.created, DateTime.utc(2000, 1, 2, 13));
    expect(feed.items!.first.dc!.modified, DateTime.utc(2000, 1, 2, 14));
    expect(feed.items!.first.dc!.type, 'type');
    expect(feed.items!.first.dc!.format, 'format');
    expect(feed.items!.first.dc!.identifier, 'identifier');
    expect(feed.items!.first.dc!.source, 'source');
    expect(feed.items!.first.dc!.language, 'language');
    expect(feed.items!.first.dc!.relation, 'relation');
    expect(feed.items!.first.dc!.coverage, 'coverage');
    expect(feed.items!.first.dc!.rights, 'rights');
  });

  test('parse RSS-Empty.xml', () {
    var xmlString = File('test/xml/RSS-Empty.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.title, null);
    expect(feed.description, null);
    expect(feed.link, null);
    expect(feed.language, null);
    expect(feed.lastBuildDate, null);
    expect(feed.generator, null);
    expect(feed.copyright, null);
    expect(feed.docs, null);
    expect(feed.managingEditor, null);
    expect(feed.rating, null);
    expect(feed.webMaster, null);
    expect(feed.ttl, 0);

    expect(feed.image, null);

    expect(feed.cloud, null);

    expect(feed.categories!.length, 0);

    expect(feed.skipDays!.length, 0);

    expect(feed.skipHours!.length, 0);

    expect(feed.items!.length, 1);

    expect(feed.items!.first.title, null);
    expect(feed.items!.first.description, null);
    expect(feed.items!.first.link, null);
    expect(feed.items!.first.guid, null);
    expect(feed.items!.first.pubDate, null);
    expect(feed.items!.first.categories!.length, 0);
    expect(feed.items!.first.author, null);
    expect(feed.items!.first.source, null);
    expect(feed.items!.first.comments, null);
    expect(feed.items!.first.enclosure, null);

    expect(feed.items!.first.content, null);
  });

  test('parse RSS-Itunes.xml', () {
    var xmlString = File('test/xml/RSS-Itunes.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.itunes!.author, 'Changelog Media');
    expect(feed.itunes!.summary, 'Foo');
    expect(feed.itunes!.explicit, false);
    expect(feed.itunes!.image!.href,
        'https://cdn.changelog.com/uploads/covers/go-time-original.png?v=63725770357');
    expect(feed.itunes!.keywords,
        'go,golang,open source,software,development'.split(','));
    expect(feed.itunes!.owner!.name, 'Changelog Media');
    expect(feed.itunes!.owner!.email, 'editors@changelog.com');
    expect(
        Set.from([
          feed.itunes!.categories![0].category,
          feed.itunes!.categories![1].category
        ]),
        ['Technology', 'Foo']);
    for (var category in feed.itunes!.categories!) {
      switch (category.category) {
        case 'Foo':
          expect(category.subCategories, ['Bar', 'Baz']);
          break;
        case 'Technology':
          expect(category.subCategories, ['Software How-To', 'Tech News']);
          break;
      }
    }
    expect(feed.itunes!.title, 'Go Time');
    expect(feed.itunes!.type, ItunesType.serial);
    expect(feed.itunes!.newFeedUrl, 'wubawuba');
    expect(feed.itunes!.block, true);
    expect(feed.itunes!.complete, true);

    var item = feed.items![0];
    expect(item.itunes!.episodeType, ItunesEpisodeType.full);
    expect(item.itunes!.episode, 1);
    expect(item.itunes!.season, 1);
    expect(item.itunes!.image!.href,
        'https://cdn.changelog.com/uploads/covers/go-time-original.png?v=63725770357');
    expect(item.itunes!.duration, Duration(minutes: 32, seconds: 30));
    expect(item.itunes!.explicit, false);
    expect(item.itunes!.keywords,
        'go,golang,open source,software,development'.split(','));
    expect(item.itunes!.subtitle, 'with Erik, Carlisia, and Brian');
    expect(item.itunes!.summary, 'Foo');
    expect(item.itunes!.author,
        'Erik St. Martin, Carlisia Pinto, and Brian Ketelsen');
    expect(item.itunes!.explicit, false);
    expect(item.itunes!.title, 'awesome title');
    expect(item.itunes!.block, false);
  });

  test('parse RSS-RDF.xml', () {
    var xmlString = File('test/xml/RSS-RDF.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.title, 'Mozilla Dot Org');
    expect(feed.link, 'http://www.mozilla.org');
    expect(feed.description, 'the Mozilla Organization web site');
    expect(feed.image!.title, 'Mozilla');
    expect(feed.image!.url, 'http://www.mozilla.org/images/moz.gif');
    expect(feed.image!.link, 'http://www.mozilla.org');
    expect(feed.items!.length, 5);
    expect(feed.items!.first.title, 'New Status Updates');
    expect(feed.items!.first.link, 'http://www.mozilla.org/status/');
  });

  test('parse RSS-Syndication.xml', () {
    var xmlString = File('test/xml/RSS-Syndication.xml').readAsStringSync();

    var feed = RssFeed.parse(xmlString);

    expect(feed.title, 'Meerkat');
    expect(feed.link, 'http://meerkat.oreillynet.com');
    expect(feed.description, 'Meerkat: An Open Wire Service');
    expect(feed.image!.title, 'Meerkat Powered!');
    expect(feed.image!.url,
        'http://meerkat.oreillynet.com/icons/meerkat-powered.jpg');
    expect(feed.image!.link, 'http://meerkat.oreillynet.com');
    expect(feed.syndication!.updatePeriod, SyndicationUpdatePeriod.hourly);
    expect(feed.syndication!.updateFrequency, 2);
    expect(feed.syndication!.updateBase, DateTime.utc(2001, 1, 1, 12, 1));
    expect(feed.items!.length, 1);
    expect(feed.items!.first.title, 'XML: A Disruptive Technology');
    expect(feed.items!.first.description,
        'XML is placing increasingly heavy loads on the existing technical infrastructure of the Internet.');
    expect(feed.items!.first.link, 'http://c.moreover.com/click/here.pl?r123');
  });
}
