import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univeos/src/api/tui_provider.dart';
import 'package:univeos/src/bloc/rest_info.dart';
import 'package:univeos/src/models/tui_model.dart';
import 'dart:convert';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:univeos/src/utils/user_preferences.dart';

// https://github.com/flutter/flutter/issues/34947
class TuiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestInfo>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Tarjeta virtual'),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/qr_round.png',
                  color: Colors.white,
                  colorBlendMode: BlendMode.srcIn,
                  scale: 3),
              onPressed: () {
                if (provider.tui.render != null) {
                  Navigator.pushNamed(context, 'qr',
                      arguments: provider.tui.render);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.fullscreen),
              iconSize: 40.0,
              onPressed: () {
                if (provider.tui.render != null) {
                  Navigator.pushNamed(context, 'tui',
                      arguments: provider.tui.render);
                }
              },
            ),
          ],
        ),
        body: _buildTui(context, provider));
  }

  Widget _buildTui(BuildContext context, RestInfo provider) {
    return FutureBuilder(
      future: TuiProvider().logint(
          provider.userInfo.id.toString(), UserPreferences().accessToken),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildCard(context, provider, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildCard(BuildContext context, RestInfo provider, String bearer) {
    return FutureBuilder(
      future: TuiProvider().cardUpdate(bearer, provider.userInfo),
      builder: (BuildContext context, AsyncSnapshot<TuiModel> snapshot) {
        if (snapshot.hasData) {
          provider.tui = snapshot.data;

          return SafeArea(
            child: Column(
              children: <Widget>[
                _barcode(snapshot.data.render.barcode),
                _card(snapshot.data.render),
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
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: FlipCard(
        front: RotatedBox(
            quarterTurns: 5, child: Image.memory(base64Decode(render.front))),
        back: RotatedBox(
            quarterTurns: 5, child: Image.memory(base64Decode(render.back))),
      ),
    );
  }

  Widget _barcode(Barcode barcode) {
    return BarCodeImage(
      padding: EdgeInsets.symmetric(vertical: 70.0),
      params: Code39BarCodeParams(
        barcode.value,
        barHeight: 90.0,
        withText: false,
      ),
      onError: (error) {
        print('Barcode error: $error');
      },
    );
  }

  // Widget _buttons() {

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       IconButton(
  //         color: Palette.deepRed,
  //         iconSize: 50.0,
  //         icon: Icon(Icons.grid_on),
  //         onPressed: () {

  //         },
  //       ),
  //       SizedBox(width: 20.0),
  //       IconButton(
  //         color: Palette.deepRed,
  //         iconSize: 50.0,
  //         icon: Icon(Icons.grid_off),
  //         onPressed: () {

  //         },
  //       )
  //     ],
  //   );
  // }

}
