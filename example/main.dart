import 'package:http/http.dart' as http;
import 'client.dart';

void main() {
  var client = new WebFeedClient(new http.Client());
  client.fetch("https://developer.apple.com/news/releases/rss/releases.rss").then((channel) {
    print(channel);
  }).catchError((error) {
    print(error);
  });
}
