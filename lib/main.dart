import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/bloc/bottom_navigation_bar.dart';
import 'package:/src/bloc/user_info.dart';
import 'package:/src/pages/bottom_app_bar_page.dart';
import 'package:/src/pages/login_page.dart';
import 'package:/src/utils/constants.dart';
import 'package:/src/utils/user_preferences.dart';
 
void main() async {
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final prefs = new UserPreferences();

    print('preferencias-accessToken: ${prefs.accessToken}');
    print('preferencias-username: ${prefs.username}');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfo()),
        ChangeNotifierProvider(create: (_) => BottomNavigation()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        // initialRoute: (prefs.accessToken == '') ? 'login' : 'home',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => BottomBarHomePage(),
        },
        theme: ThemeData(
          primaryColor: Constants.deepRed,
          accentColor: Constants.deepRed,
        ),
      ),
    );
  }

}