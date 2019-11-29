import 'package:xml/xml.dart';

class Price {
  final double price;
  final String type;
  final Uri info;
  final String currency;

  Price({
    this.price,
    this.type,
    this.info,
    this.currency,
  });

  factory Price.parse(XmlElement element) {
    var info = element.getAttribute("info");
    return Price(
      price: double.tryParse(element.getAttribute("price") ?? "0"),
      type: element.getAttribute("type"),
      info: info == null ? null : Uri.parse(info),
      currency: element.getAttribute("currency"),
    );
  }
}
