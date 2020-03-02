import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/login_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/utils/palette.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  final loginProvider = new LoginProvider();
  String password;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _background(context),
            _loginForm(context),
          ],
        ));
  }

  Widget _loginForm(BuildContext context) {
    final provider = Provider.of<RestInfo>(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.2,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 28.0)),
                SizedBox(height: 40.0),
                _usernameField(provider),
                SizedBox(height: 30.0),
                _passwordField(),
                SizedBox(height: 40.0),
                _loginButton(provider, context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _usernameField(RestInfo provider) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 55.0, 0.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email),
          labelText: 'Identificador',
        ),
        onChanged: (text) {
          provider.username = text;
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 55.0, 0.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          labelText: 'Contraseña',
        ),
        onChanged: (text) {
          password = text;
        },
      ),
    );
  }

  Widget _loginButton(RestInfo provider, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      child: Container(
        key: _globalKey,
        height: 48,
        width: _width,
        child: RaisedButton(
          child: _setLoginButton(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          padding: EdgeInsets.all(0.0),
          elevation: 3.0,
          color: Palette.deepRed,
          onPressed: () {
            setState(() {
              if (_state == 0) {
                _animateButton();
                _login(provider, context);
              }
            });
          },
        ),
      ),
    );
  }

  Widget _setLoginButton() {
    if (_state == 0) {
      return Text(
        "Acceder",
        style: TextStyle(color: Colors.white, fontSize: 17, letterSpacing: 1.0),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void _animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });
  }

  void _resetButton() {
    setState(() {
      _width = double.maxFinite;
      _state = 0;
    });
  }

  Widget _background(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Palette.deepRed, Palette.lightRed])),
    );

    return Stack(
      children: <Widget>[
        background,
        Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.1, horizontal: size.width * 0.38),
          child: Icon(Icons.person_pin, color: Colors.white, size: 100.0),
        )
      ],
    );
  }

  Future<void> _login(RestInfo provider, BuildContext context) async {

    final token = await loginProvider.post(provider.username, password);

    print('login-token: $token');

    if (token != null) {
      setState(() {
        _state = 2;
      });

      Navigator.pushReplacementNamed(context, 'home');
    } else {
      final snackBar = SnackBar(content: Text('Usuario o contraseña incorrectos'));
      _scaffoldKey.currentState.showSnackBar(snackBar);

      _resetButton();
    }
  }

}