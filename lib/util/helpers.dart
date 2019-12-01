import 'dart:core';

import 'package:xml/xml.dart';

XmlElement findElementOrNull(XmlElement element, String name, {String namespace}) {
  try {
    return element.findAllElements(name, namespace: namespace).first;
  } on StateError {
    return null;
  }
}

List<XmlElement> findAllDirectElementsOrNull(XmlElement element, String name, {String namespace}) {
  try {
    return element.findElements(name, namespace: namespace).toList();
  } on StateError {
    return null;
  }
}

String parseTextLiteral(XmlElement element, String name, {String namespace}) {
  var s = findElementOrNull(element, name, namespace: namespace)?.text;
  return s == null || s.isEmpty ? null : s;
}

bool parseBoolLiteral(XmlElement element, String name, {String namespace}) {
  var s = parseTextLiteral(element, name, namespace: namespace)?.toLowerCase()?.trim();
  return s == null
      ? null
      : [
          "yes",
          "true"
        ].contains(s);
}

Uri parseUriLiteral(XmlElement element, String name, {String namespace}) {
  var s = parseTextLiteral(element, name, namespace: namespace);
  return s == null ? null : Uri.parse(s);
}

DateTime parseDateTimeLiteral(XmlElement element, String name, {String namespace}) {
  var s = parseTextLiteral(element, name, namespace: namespace);
  return s == null ? null : DateTime.parse(s);
}
