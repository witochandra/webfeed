import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#value-recipient
class ValueRecipient {
  final String? name;
  final String? customKey;
  final String? customValue;
  final String? type;
  final String? address;
  final int? split;
  final bool fee;

  ValueRecipient({
    this.name,
    this.customKey,
    this.customValue,
    this.type,
    this.address,
    this.split,
    required this.fee,
  });

  factory ValueRecipient.parse(XmlElement element) {
    final splitStr = element.getAttribute('split');
    final feeStr = element.getAttribute('fee');
    return ValueRecipient(
      name: element.getAttribute('name'),
      customKey: element.getAttribute('customKey'),
      customValue: element.getAttribute('customValue'),
      type: element.getAttribute('type'),
      address: element.getAttribute('address'),
      split: splitStr == null ? null : int.tryParse(splitStr),
      fee: feeStr?.toLowerCase() == 'true',
    );
  }
}
