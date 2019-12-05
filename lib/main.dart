import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/bloc/bottom_navigation_bar.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/pages/bottom_app_bar_page.dart';
import 'package:/src/pages/login_page.dart';
import 'package:/src/pages/news_display_page.dart';
import 'package:/src/utils/palette.dart';
import 'package:/src/utils/user_preferences.dart';
import 'package:/src/utils/utils.dart';
 
void main() async {
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  Utils.setPortraitModeOnly();

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
        ChangeNotifierProvider(create: (_) => RestInfo()),
        ChangeNotifierProvider(create: (_) => BottomNavigation()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        // initialRoute: (prefs.accessToken == '') ? 'login' : 'home',
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => BottomBarHomePage(),
          'news' : (BuildContext context) => NewsDisplayPage(),
        },
        theme: ThemeData(
          primaryColor: Palette.deepRed,
          accentColor: Palette.deepRed,
        ),
      ),
    );
  }

}