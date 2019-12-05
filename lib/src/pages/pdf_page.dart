import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


class PdfPage extends StatelessWidget {

  final String title;
  final PDFDocument document;

  PdfPage({this.title, this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PDFViewer(document: document, showPicker: false),
    );
  }

}