import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

void main() async {
  var client = new http.Client();

  // RSS feed
  var rssresp = await client.get("https://developer.apple.com/news/releases/rss/releases.rss");
  var channel = new RssFeed.parse(rssresp.body);
  print(channel);

  // Atom feed
  var atomresp = await client.get("https://www.theverge.com/rss/index.xml");
  var feed = new AtomFeed.parse(atomresp.body);
  print(feed);
}
