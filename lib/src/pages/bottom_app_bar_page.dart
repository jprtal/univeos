import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/bloc/bottom_navigation_bar.dart';
import 'package:/src/pages/home_page.dart';

class BottomBarHomePage extends StatefulWidget {

  @override
  _BottomBarHomePageState createState() => _BottomBarHomePageState();
}

class _BottomBarHomePageState extends State<BottomBarHomePage> {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<BottomNavigation>(context);

    return Scaffold(
      body: _callPage(provider.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu),
        onPressed: () {
        }
      ),
    );
  }

  Widget _callPage(int page) {
    switch (page) {
      case 0: return HomePage();
      case 1: return HomePage();
      default: return HomePage();
    }
  }
  
}