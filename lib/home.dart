import 'package:flutter/material.dart';
import 'package:playandwin/MainScreen/NotificationPage.dart';
import 'package:playandwin/MainScreen/PaymentPage.dart';
import 'package:playandwin/MainScreen/ProfilePage.dart';
import 'package:playandwin/MainScreen/SettingPage.dart';
import 'package:playandwin/util/colors.dart';

import 'MainScreen/HomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NotificationScreen(),
    PaymentScreen(),
    SettingScreen(),  ];

  void _onItemTapped(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play & Win'),
        backgroundColor: cardColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_home.png'), color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_notification.png'), color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_wallet.png'), color: Colors.black),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_setting.png'), color: Colors.black),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
