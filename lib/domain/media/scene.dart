import 'package:webfeed/util/helpers.dart';
import 'package:xml/xml.dart';

class Scene {
  final String title;
  final String description;
  final String startTime;
  final String endTime;

  Scene({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
  });

  factory Scene.parse(XmlElement element) {
    if (element == null) return null;
    return Scene(
      title: parseTextLiteral(element, "sceneTitle"),
      description: parseTextLiteral(element, "sceneDescription"),
      startTime: parseTextLiteral(element, "sceneStartTime"),
      endTime: parseTextLiteral(element, "sceneEndTime"),
    );
  }
}
