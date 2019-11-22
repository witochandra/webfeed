import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/domain/rss1_feed.dart';

void main() {
  test('parse basic RSS 1.0', () {
    final xmlString = File('test/xml/RSS1-basic.xml').readAsStringSync();
    final feed = new Rss1Feed.parse(xmlString);

    expect(feed.title, 'XML.com');
    expect(feed.link, 'http://xml.com/pub');
    expect(
      feed.description,
      'XML.com features a rich mix of information and services for the XML community.',
    );
    expect(feed.image, 'http://xml.com/universal/images/xml_tiny.gif');

    expect(feed.items.length, 2);

    final firstItem = feed.items.first;
    expect(firstItem.title, 'Processing Inclusions with XSLT');
    expect(firstItem.link, 'http://xml.com/pub/2000/08/09/xslt/xslt.html');
    expect(firstItem.description,
        'Processing document inclusions with general XML tools can be problematic. This article proposes a way of preserving inclusion information through SAX-based processing.');
  });

  test('parse RSS1 with syndication module', () {
    final xmlString =
        File('test/xml/RSS1-with-syndication-module.xml').readAsStringSync();
    final feed = new Rss1Feed.parse(xmlString);

    expect(feed.title, 'Meerkat');
    expect(feed.link, 'http://meerkat.oreillynet.com');
    expect(feed.description, 'Meerkat: An Open Wire Service');

    expect(feed.updatePeriod, UpdatePeriod.Hourly);
    expect(feed.updateFrequency, 2);
    expect(feed.updateBase, DateTime.parse('2000-01-01T12:00+00:00'));
  });

  test('parse RSS1 with dublin core module', () {
    final xmlString =
        File('test/xml/RSS1-with-dublin-core-module.xml').readAsStringSync();
    final feed = new Rss1Feed.parse(xmlString);

    expect(feed.title, 'Meerkat');
    expect(feed.link, 'http://meerkat.oreillynet.com');
    expect(feed.description, 'Meerkat: An Open Wire Service');

    expect(feed.dc.publisher, 'The O\'Reilly Network');
    expect(feed.dc.creator, 'Rael Dornfest (mailto:rael@oreilly.com)');
    expect(feed.dc.rights, 'Copyright © 2000 O\'Reilly & Associates, Inc.');
    expect(feed.dc.date, DateTime.parse('2000-01-01T12:00+00:00'));

    final firstItem = feed.items.first;
    expect(
      firstItem.dc.description,
      'XML is placing increasingly heavy loads on the existing technical infrastructure of the Internet.',
    );
    expect(firstItem.dc.publisher, 'The O\'Reilly Network');
    expect(
      firstItem.dc.creator,
      'Simon St.Laurent (mailto:simonstl@simonstl.com)',
    );
    expect(
        firstItem.dc.rights, 'Copyright © 2000 O\'Reilly & Associates, Inc.');
    expect(firstItem.dc.subject, 'XML');
  });

  test('parse RSS1 with content module', () {
    final xmlString =
        File('test/xml/RSS1-with-content-module.xml').readAsStringSync();
    final feed = new Rss1Feed.parse(xmlString);

    expect(feed.title, 'Example Feed');
    expect(feed.link, 'http://www.example.org');
    expect(feed.description, 'Simply for the purpose of demonstration.');

    final firstItem = feed.items.first;
    expect(
      firstItem.content.value,
      '<p>What a <em>beautiful</em> day!</p>',
    );
    expect(
      firstItem.content.images,
      Iterable.empty(),
    );
  });

  // Japanese Social Bookmark Service "Hatena Bookmark" is still using RSS1.0!
  // As I don't know english service using RSS 1.0, I use Japanese service for test case.
  test("parse production RSS1.0", () {
    var xmlString =
        new File("test/xml/RSS1-production_hatena.xml").readAsStringSync();

    var feed = new Rss1Feed.parse(xmlString);

    expect(feed.title, 'sampleのはてなブックマーク');
    expect(feed.link, 'https://b.hatena.ne.jp/sample/bookmark');
    expect(feed.description, 'sampleのはてなブックマーク (17)');

    expect(feed.items.length, 17);

    final firstItem = feed.items.first;

    expect(firstItem.description, '');
    expect(firstItem.title, 'はてなスタッフのブックマーク拝見！ - 営業マン編「仕事の様々なシーンでフル活用」');
    expect(firstItem.link, 'http://b.hatena.ne.jp/guide/staff_bookmark_03');
    expect(firstItem.creator, 'sample');
    expect(firstItem.date, DateTime.parse('2009-04-10T09:44:20Z'));
    expect(firstItem.subjects[0], 'はてな');
    expect(firstItem.subjects[1], 'インタビュー');
    expect(firstItem.subjects[2], 'はてなブックマーク');
    expect(firstItem.dc.date, DateTime.parse('2009-04-10T09:44:20Z'));
  });
}
