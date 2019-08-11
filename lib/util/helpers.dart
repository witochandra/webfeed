import 'dart:core';

import 'package:xml/xml.dart';

XmlElement findElementOrNull(XmlElement element, String name, {String namespace}) {
  try {
    return element.findAllElements(name, namespace: namespace).first;
  } on StateError {
    return null;
  }
}
