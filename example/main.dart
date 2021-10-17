import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed/webfeed.dart';

void main() async {
  final client = IOClient(HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true));

  // RSS feed
  var response = await client.get(
      Uri.parse('https://developer.apple.com/news/releases/rss/releases.rss'));
  var channel = RssFeed.parse(response.body);
  print(channel);

  // Atom feed
  response =
      await client.get(Uri.parse('https://www.theverge.com/rss/index.xml'));
  var feed = AtomFeed.parse(response.body);
  print(feed);

  client.close();
}
