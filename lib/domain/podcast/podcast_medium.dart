import 'package:xml/xml.dart';

enum MediumType { podcast, music, video, film, audiobook, newsletter, blog }

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#medium
class Medium {
  final MediumType value;

  Medium({
    required this.value,
  });

  factory Medium.parse(XmlElement element) {
    return Medium(
      value: newPodcastMediumType(element.text),
    );
  }
}

MediumType newPodcastMediumType(String value) {
  switch (value) {
    case 'podcast':
      return MediumType.podcast;
    case 'music':
      return MediumType.music;
    case 'video':
      return MediumType.video;
    case 'film':
      return MediumType.film;
    case 'audiobook':
      return MediumType.audiobook;
    case 'newletter':
      return MediumType.newsletter;
    case 'blog':
      return MediumType.blog;
    default:
      return MediumType.podcast;
  }
}
