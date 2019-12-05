import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:/src/pages/pdf_page.dart';
import 'package:/src/pages/webview_page.dart';

class Utils {

  static void showWebview(BuildContext context, String title, String url) async {
    Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new WebViewWebPage(title: title, url: url);
    }));
  }

  static void showPdf(BuildContext context, String title, String url) async {
    PDFDocument document = await PDFDocument.fromURL(url);

    Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new PdfPage(document: document, title: title);
    }));
  }

  static void setPortraitModeOnly() {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
  }

}