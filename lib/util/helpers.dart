import 'dart:core';

import 'package:xml/xml.dart';

XmlElement findElementOrNull(XmlElement element, String name) 
{
	try 
	{
		Iterable v = element.findAllElements(name);
		if (v.isNotEmpty)
			return v.first;
		else 
			return null;
	} 
	on StateError 
	{
		return null;
	}
}
