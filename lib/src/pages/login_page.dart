import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/login_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/utils/palette.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginProvider = new LoginProvider();
  String password;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _background(context),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {

    final provider = Provider.of<RestInfo>(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 170.0,
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
                  spreadRadius: 3.0
                )
              ]
            ),
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

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      elevation: 3.0,
      color: Palette.deepRed,
      textColor: Colors.white,
      onPressed: () => _login(provider, context)
    );
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
          colors: <Color> [
            Palette.deepRed,
            Palette.lightRed
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Container(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: size.width * 0.38),
          child: Icon(Icons.person_pin, color: Colors.white, size: 100.0),
        )
      ],
    );
  }

  _login(RestInfo bloc, BuildContext context) async {
    print('login-email: ${bloc.username}');
    print('login-password: $password');

    final token = await loginProvider.post(bloc.username, password);

    print('login-token: $token');

    if (token != null) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }
  
}