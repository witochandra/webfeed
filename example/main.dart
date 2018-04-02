import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

void main() {
  var client = new http.Client();
  client.get("https://developer.apple.com/news/releases/rss/releases.rss").then((response) {
    return response.body;
  }).then((bodyString) {
    var channel = new RssFeed.parse(bodyString);
    print(channel);
    return channel;
  });
}
