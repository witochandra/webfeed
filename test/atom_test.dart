import 'dart:io';
import 'dart:core';
import 'package:test/test.dart';
import 'package:webfeed/domain/atom_feed.dart';

void main() {
  test("parsing Invalid.xml", () {
    var xmlString = new File("test/xml/Invalid.xml").readAsStringSync();

    try {
      new AtomFeed.parse(xmlString);
      fail("Should throw Argument Error");
    } on ArgumentError {}
  });
  
  test("parsing Atom.xml", () {
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
}