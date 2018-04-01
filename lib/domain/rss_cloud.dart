import 'package:xml/xml.dart';

class RssCloud {
  String domain;
  String port;
  String path;
  String registerProcedure;
  String protocol;

  RssCloud(this.domain, this.port, this.path, this.registerProcedure, this.protocol);

  factory RssCloud.parse(XmlElement node) {
    var domain = node.getAttribute("domain");
    var port = node.getAttribute("port");
    var path = node.getAttribute("path");
    var registerProcedure = node.getAttribute("registerProcedure");
    var protocol = node.getAttribute("protocol");
    return new RssCloud(domain, port, path, registerProcedure, protocol);
  }

  @override
  String toString() {
    return '''
      domain: $domain
      port: $port
      path: $path
      registerProcedure: $registerProcedure
      protocol: $protocol
    ''';
  }
}
