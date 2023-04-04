import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playandwin/DetailScreen/QuizDetail.dart';
import 'package:playandwin/MainScreen/LoginPage.dart';
import 'package:playandwin/MainScreen/OtpPage.dart';
import 'package:playandwin/MainScreen/ProfilePage.dart';
import 'package:playandwin/home.dart';

import 'MainScreen/PaymentPage.dart';
import 'MainScreen/RankPage.dart';
import 'MainScreen/SplashPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play & Win',
      home: LoginScreen(),
      /*initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => quizScreen(),
      },*/
    );
  }
}


