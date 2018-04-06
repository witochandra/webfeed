# WebFeed

[![Build Status](https://travis-ci.org/witochandra/webfeed.svg?branch=master)](https://travis-ci.org/witochandra/webfeed)

A dart package for parsing RSS and Atom feed.

### Features

- [x] RSS
- [x] Atom
- [ ] JSON

### Installing

Add this line into your `pubspec.yaml`
```
webfeed: ^0.1.0
```

Import the package into your dart code using:
```
import 'package:webfeed/domain/rss_feed.dart'; // for parsing RSS feed
import 'package:webfeed/domain/atom_feed.dart'; // for parsing Atom feed
```

### Example

To parse string into `RssFeed` object use:
```
var rssFeed = new RssFeed.parse(xmlString); // for parsing RSS feed
var atomFeed = new AtomFeed.parse(xmlString); // for parsing Atom feed
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

**Atom**
```
feed.id
feed.title
feed.updated
feed.items
feed.links
feed.authors
feed.contributors
feed.categories
feed.generator
feed.icon
feed.logo
feed.rights
feed.subtitle

AtomItem item = feed.items.first;
item.id
item.title
item.updated
item.authors
item.links
item.categories
item.contributors
item.source
item.published
item.content
item.summary
item.rights
```

## License

WebFeed is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
