import 'dart:io';
import 'dart:core';
import 'package:test/test.dart';
import 'package:webfeedclient/domain/channel.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  test("parsing Invalid.xml", () {
    var xmlString = new File("test/examples/Invalid.xml").readAsStringSync();
    var doc = xml.parse(xmlString);

    try {
      new Channel.parse(doc);
      fail("Should throw Argument Error");
    } on ArgumentError {}
  });
  test("parsing RSS.xml", () {
    var xmlString = new File("test/examples/RSS.xml").readAsStringSync();
    var doc = xml.parse(xmlString);

    var channel = new Channel.parse(doc);

    expect(channel.title, "News - Foo bar News");
    expect(channel.description, "Foo bar News and Updates feed provided by Foo bar, Inc.");
    expect(channel.link, "https://foo.bar.news/");
    expect(channel.language, "en-US");
    expect(channel.lastBuildDate, "Mon, 26 Mar 2018 14:00:00 PDT");
    expect(channel.generator, "Custom");
    expect(channel.copyright, "Copyright 2018, Foo bar Inc.");

    expect(channel.image.title, "Foo bar News");
    expect(channel.image.url, "https://foo.bar.news/logo.gif");
    expect(channel.image.link, "https://foo.bar.news/");

    expect(channel.items.length, 2);

    expect(channel.items.first.title, "The standard Lorem Ipsum passage, used since the 1500s");
    expect(channel.items.first.description, "Lorem ipsum dolor sit amet, consectetur adipiscing elit");
    expect(channel.items.first.link, "https://foo.bar.news/1");
    expect(channel.items.first.guid, "https://foo.bar.news/1?guid");
    expect(channel.items.first.pubDate, "Mon, 26 Mar 2018 14:00:00 PDT");
  });
}
