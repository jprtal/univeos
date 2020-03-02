import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/user_info_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/utils/user_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    UserInfoProvider().post(UserPreferences().accessToken).then((data) {
      if (data == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Provider.of<RestInfo>(context, listen: false).userInfo = data;
        Navigator.pushReplacementNamed(context, 'home');
      }
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 250, 250, 250),
      // child: Center(child: CircularProgressIndicator())
    );
  }
}
