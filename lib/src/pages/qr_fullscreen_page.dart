import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:/src/models/tui_model.dart';

import 'package:/src/utils/palette.dart';

class QrFullscreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Render data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Palette.deepRed),
      ),
      body: _buildQr(data)
    );
  }


  Widget _buildQr(Render render) {

    return SafeArea(
      child: Center(
        child: QrImage(
          data: render.qrcode.value,
          version: QrVersions.auto,
          size: 300.0,
        )
      ),
    );
  }

}