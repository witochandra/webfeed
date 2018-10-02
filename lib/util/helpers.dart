import 'dart:core';

import 'package:xml/xml.dart';

XmlElement findElementOrNull(XmlElement element, String name) {
  try {
    return element.findAllElements(name).first;
  } on StateError {
    return null;
  }
}
