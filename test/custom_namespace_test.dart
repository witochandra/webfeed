import 'dart:core';
import 'dart:io';

import 'package:test/test.dart';
// import 'package:webfeed/domain/itunes/itunes_episode_type.dart';
// import 'package:webfeed/domain/itunes/itunes_type.dart';
// import 'package:webfeed/domain/syndication/syndication.dart';
import 'package:webfeed/webfeed.dart';

void main() {
  test('Loads tags into customNamespace map.xml', () {
    final expectValues = <Map<String, String>>[
      {
        'g-core:price': '26500.0',
        'geo:lat': '50.43701',
        'geo:long': '-104.62499',
      },
      {
        'g-core:price': '7495.0',
        'geo:lat': '50.4631',
        'geo:long': '-104.59493',
      },
      {
        'g-core:price': '7998.0',
        'geo:lat': '50.48064',
        'geo:long': '-104.61908',
      },  
      {
        'g-core:price': '22495.0',
        'geo:lat': '50.46893',
        'geo:long': '-104.61199',
      }
    ];

    final feed = RssFeed.parse(File('test/xml/Custom.xml').readAsStringSync());

    expect(feed.title, 'Latest Kijiji ads. Location: Regina. Category: Cars & Trucks');
    expect(feed.items!.length, 4);

    var mapIndex = 0;
    for (var item in feed.items!) {
      expect(item.customNamespace!.valueForKey('g-core:price'), expectValues[mapIndex]['g-core:price']);
      expect(item.customNamespace!.valueForKey('geo:lat'), expectValues[mapIndex]['geo:lat']);
      expect(item.customNamespace!.valueForKey('geo:long'), expectValues[mapIndex]['geo:long']);

      mapIndex++;
    }
  });
}
