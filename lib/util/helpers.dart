import 'dart:core';

import 'package:xml/xml.dart';

String xmlGetString(XmlElement element, String name, {strict: true}) {
  try {
    return element
        .findElements(name)
        .first
        .text;
  } on StateError {
    if (strict) {
      throw new ArgumentError("$name not found");
    }
  }
  return null;
}
