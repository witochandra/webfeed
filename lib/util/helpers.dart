import 'dart:core';

import 'package:xml/xml.dart';

String xmlGetString(XmlElement element, String name, {strict: true}) {
  try {
    return element.findElements(name).first.text;
  } on StateError {
    if (strict) {
      throw new ArgumentError("$name not found");
    }
  }
  return null;
}

int xmlGetInt(XmlElement element, String name, {strict: true}) {
  var value = xmlGetString(element, name, strict: strict);
  if (value != null) {
    try {
      return int.parse(value);
    } on FormatException {
      if (strict) {
        throw new ArgumentError("$name has invalid format");
      }
    }
  }
  return null;
}
