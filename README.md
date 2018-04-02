# WebFeed

[![Build Status](https://travis-ci.org/witochandra/webfeed.svg?branch=master)](https://travis-ci.org/witochandra/webfeed)

A dart package for parsing RSS feed.

### Features

- [x] RSS
- [ ] Atom
- [ ] JSON

### Installing

Add these lines into your `pubspec.yaml`
```
webfeed:
  git: git@github.com:witochandra/webfeed.git
```

Import the package into your dart code using:
```
import 'package:webfeed/domain/rss_feed.dart';
```

### Example

To parse string into `RssFeed` object use:
```
new RssFeed.parse(xmlString);
```

### Preview

**RSS**
```
feed.title
feed.description
feed.link
feed.items
feed.image
feed.cloud
feed.categories
feed.skipDays
feed.skipHours
feed.lastBuildDate
feed.language
feed.generator
feed.copyright
feed.docs
feed.managingEditor
feed.rating
feed.webMaster
feed.ttl

RssItem item = feed.items.first;
item.title
item.description
item.link
item.categories
item.guid
item.pubDate
item.author
item.comments
item.source
```

## License

WebFeed is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
