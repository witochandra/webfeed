import 'package:webfeed/domain/podcast/podcast_value_recipient.dart';
import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#value
class Value {
  final String? type;
  final String? method;
  final String? suggested;
  final List<ValueRecipient> valueRecipients;

  Value({
    this.type,
    this.method,
    this.suggested,
    required this.valueRecipients,
  });

  factory Value.parse(XmlElement element) {
    return Value(
      type: element.getAttribute('type'),
      method: element.getAttribute('method'),
      suggested: element.getAttribute('suggested'),
      valueRecipients: element
          .findElements('podcast:valueRecipient')
          .map((e) => ValueRecipient.parse(e))
          .toList(),
    );
  }
}
