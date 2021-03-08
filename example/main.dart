import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

void main() async {
  var client = http.Client();

  // RSS feed
  var response = await client.get(
      Uri(path: 'https://developer.apple.com/news/releases/rss/releases.rss'));
  var channel = RssFeed.parse(response.body);
  print(channel);

  // Atom feed
  response =
      await client.get(Uri(path: 'https://www.theverge.com/rss/index.xml'));
  var feed = AtomFeed.parse(response.body);
  print(feed);

  client.close();
}
