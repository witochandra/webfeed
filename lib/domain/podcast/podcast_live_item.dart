import 'package:webfeed/domain/rss_item.dart';
import 'package:xml/xml.dart';

enum LiveItemStatus { pending, live, ended }

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#live-item
class LiveItem {
  final LiveItemStatus? status;
  final DateTime? start;
  final DateTime? end;
  final RssItem item;

  LiveItem({
    this.status,
    this.start,
    this.end,
    required this.item,
  });

  factory LiveItem.parse(XmlElement element) {
    final startStr = element.getAttribute('start');
    final endStr = element.getAttribute('end');
    return LiveItem(
      status: newPodcastLiveItemStatusType(element.getAttribute('status')),
      start: startStr == null ? null : DateTime.tryParse(startStr),
      end: endStr == null ? null : DateTime.tryParse(endStr),
      item: RssItem.parse(element),
    );
  }
}

LiveItemStatus? newPodcastLiveItemStatusType(String? value) {
  switch (value) {
    case 'pending':
      return LiveItemStatus.pending;
    case 'live':
      return LiveItemStatus.live;
    case 'ended':
      return LiveItemStatus.ended;
    default:
      return null;
  }
}
