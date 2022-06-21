import 'package:xml/xml.dart';

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#soundbite
class Soundbite {
  final double? startTime;
  final double? duration;
  final String? value;

  Soundbite({
    this.startTime,
    this.duration,
    this.value,
  });

  factory Soundbite.parse(XmlElement element) {
    final startTimeStr = element.getAttribute('startTime');
    final durationStr = element.getAttribute('duration');
    return Soundbite(
      startTime: startTimeStr != null ? double.tryParse(startTimeStr) : null,
      duration: durationStr != null ? double.tryParse(durationStr) : null,
      value: element.text,
    );
  }
}
