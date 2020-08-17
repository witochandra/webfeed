import 'package:webfeed/util/datetime.dart';
import 'package:webfeed/util/xml.dart';
import 'package:xml/xml.dart';

enum SyndicationUpdatePeriod { hourly, daily, weekly, monthly, yearly }

class Syndication {
  final SyndicationUpdatePeriod updatePeriod;
  final int updateFrequency;
  final DateTime updateBase;

  Syndication({
    this.updatePeriod,
    this.updateFrequency,
    this.updateBase,
  });

  factory Syndication.parse(XmlElement element) {
    if (element == null) {
      return null;
    }
    SyndicationUpdatePeriod updatePeriod;
    switch (findFirstElement(element, 'sy:updatePeriod')?.text) {
      case 'hourly':
        updatePeriod = SyndicationUpdatePeriod.hourly;
        break;
      case 'daily':
        updatePeriod = SyndicationUpdatePeriod.daily;
        break;
      case 'weekly':
        updatePeriod = SyndicationUpdatePeriod.weekly;
        break;
      case 'monthly':
        updatePeriod = SyndicationUpdatePeriod.monthly;
        break;
      case 'yearly':
        updatePeriod = SyndicationUpdatePeriod.yearly;
        break;
      default:
        updatePeriod = SyndicationUpdatePeriod.daily;
        break;
    }
    return Syndication(
      updatePeriod: updatePeriod,
      updateFrequency: int.tryParse(
          findFirstElement(element, 'sy:updateFrequency')?.text ?? '1'),
      updateBase:
          parseDateTime(findFirstElement(element, 'sy:updateBase')?.text),
    );
  }
}
