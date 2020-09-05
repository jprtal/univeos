import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univeos/src/bloc/bottom_navigation_bar.dart';
import 'package:univeos/src/bloc/rest_info.dart';
import 'package:univeos/src/pages/bottom_app_bar_page.dart';
import 'package:univeos/src/pages/login_page.dart';
import 'package:univeos/src/pages/news_display_page.dart';
import 'package:univeos/src/pages/qr_fullscreen_page.dart';
import 'package:univeos/src/pages/splash_page.dart';
import 'package:univeos/src/pages/tui_fullscreen_page.dart';
import 'package:univeos/src/pages/tui_page.dart';
import 'package:univeos/src/utils/palette.dart';
import 'package:univeos/src/utils/user_preferences.dart';
import 'package:univeos/src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

    // TODO: clean this provider nonsense
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestInfo()),
        ChangeNotifierProvider(create: (_) => BottomNavigation()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'univeos',
        initialRoute: (prefs.accessToken == '') ? 'login' : 'splash',
        // initialRoute: 'home',
        routes: {
          'splash': (context) => SplashPage(),
          'login': (context) => LoginPage(),
          'home': (context) => BottomBarHomePage(),
          'news': (context) => NewsDisplayPage(),
          'profile': (context) => TuiPage(),
          'tui': (context) => TuiFullscreenPage(),
          'qr': (context) => QrFullscreenPage(),
        },
        theme: ThemeData(
          primaryColor: Palette.deepRed,
          accentColor: Palette.deepRed,
        ),
      ),
    );
  }
}
