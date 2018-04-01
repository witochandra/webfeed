import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:webfeedclient/domain/rss_feed.dart';
import 'package:xml/xml.dart' as xml;

class WebFeedClient {
  http.Client client;

  WebFeedClient() {
    client = new http.Client();
  }

  Future<RssFeed> fetch(String url) {
    return client.get(url).then((response) {
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      return response.body;
    }).then((bodyString) {
      var document = xml.parse(bodyString);
      var channel = new RssFeed.parse(document);
      return channel;
    });
  }
}
