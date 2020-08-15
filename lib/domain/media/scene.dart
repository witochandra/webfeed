import 'package:webfeed/util/xml.dart';
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
    if (element == null) {
      return null;
    }
    return Scene(
      title: findFirstElement(element, 'sceneTitle')?.text,
      description: findFirstElement(element, 'sceneDescription')?.text,
      startTime: findFirstElement(element, 'sceneStartTime')?.text,
      endTime: findFirstElement(element, 'sceneEndTime')?.text,
    );
  }
}
