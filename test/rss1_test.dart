import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
import 'package:webfeed/domain/rss1_feed.dart';

void main() {
  test("parse RSS1.xml", () {
    var xmlString = new File("test/xml/RSS1.xml").readAsStringSync();

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
  });
}
