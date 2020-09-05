import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:univeos/src/models/tui_model.dart';
import 'dart:convert';

import 'package:univeos/src/utils/palette.dart';

class TuiFullscreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Render data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Tarjeta virtual', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          // textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 24.0)),
          iconTheme: IconThemeData(color: Palette.deepRed),
        ),
        body: _buildTui(data));
  }

  Widget _buildTui(Render render) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        child: FlipCard(
          front: Image.memory(base64Decode(render.front)),
          back: Image.memory(base64Decode(render.back)),
        ),
      ),
    );
  }
}
