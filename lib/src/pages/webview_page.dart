import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebViewWebPage extends StatelessWidget {

  final String title;
  final String url;

  WebViewWebPage({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      hidden: true,
      appBar: AppBar(title: Text(title)),
    );
  }

}