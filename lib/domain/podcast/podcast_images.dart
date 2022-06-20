import 'package:xml/xml.dart';

final exp = RegExp(r'([^ ]+) (\d)+w');

class Src {
  final String? url;
  final int? width;

  Src({required this.url, required this.width});
}

// https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md#images
class Images {
  final List<Src> srcset;

  Images({
    required this.srcset,
  });

  factory Images.parse(XmlElement element) {
    return Images(
      srcset: element.getAttribute('srcset')?.split(', ').map((e) {
            final matches = exp.allMatches(e).toList();
            return Src(
                url: matches[0].toString(),
                width: int.tryParse(matches[1].toString()));
          }).toList() ??
          [],
    );
  }
}
