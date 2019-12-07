import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/tui_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/models/tui_model.dart';
import 'dart:convert';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:/src/utils/palette.dart';

class TuiPage extends StatelessWidget {

  // TODO: use provider to handle all this mess
  Render render;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarjeta virtual'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fullscreen),
            iconSize: 40.0,
            onPressed: () {
              if (render != null) {
                Navigator.pushNamed(context, 'tui', arguments: render);
              }
            },
          ),
        ],
      ),
      body: _buildTui(context)
    );
  }


  Widget _buildTui(BuildContext context) {

    final provider = Provider.of<RestInfo>(context, listen: false);

    return FutureBuilder(
      future: TuiProvider().logint(provider.userInfo.id.toString(), provider.userInfo.accessToken),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {

          return _buildCard(context, snapshot.data);
        } else {

          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  Widget _buildCard(BuildContext context, String bearer) {

    final provider = Provider.of<RestInfo>(context, listen: false);

    return FutureBuilder(
      future: TuiProvider().cardUpdate(bearer, provider.userInfo),
      builder: (BuildContext context, AsyncSnapshot<TuiModel> snapshot) {
        if (snapshot.hasData) {
          render = snapshot.data.render;

          return SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                _barcode(snapshot.data.render.barcode),
                SizedBox(height: 50.0),
                _card(snapshot.data.render),
                // SizedBox(height: 50.0),
                // _buttons()
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _card(Render render) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: FlipCard(
        front: RotatedBox(
          quarterTurns: 5,
          child: Image.memory(base64Decode(render.front))
        ),
        back: RotatedBox(
          quarterTurns: 5,
          child: Image.memory(base64Decode(render.back))
        ),
      ),
    );
  }

  Widget _barcode(Barcode barcode) {

    // return QrImage(
    //   data: "1234567890",
    //   version: QrVersions.auto,
    //   size: 200.0,
    // );

    return BarCodeImage(
      params: Code39BarCodeParams(
        barcode.value,
        // lineWidth: 2.0,
        barHeight: 90.0,
        withText: false,
      ), onError: (error) {
        print('Barcode error: $error');
      },
    );
  }

  Widget _buttons() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Palette.deepRed,
          iconSize: 50.0,
          icon: Icon(Icons.grid_on),
          onPressed: () {

          },
        ),
        
        SizedBox(width: 20.0,),

        IconButton(
          color: Palette.deepRed,
          iconSize: 50.0,
          icon: Icon(Icons.grid_off),
          onPressed: () {

          },
        )
      ],
    );
  }

}