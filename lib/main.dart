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
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyDP3AjSzDn3EKayuNFq9Aqqyt3zREI9Psw",
      authDomain: "playandwin-bf7c7.firebaseapp.com",
      projectId: "playandwin-bf7c7",
      storageBucket: "playandwin-bf7c7.appspot.com",
      messagingSenderId: "696786935079",
      appId: "1:696786935079:web:de017ff0e9f73011571d02",
      measurementId: "G-GPRDSGHCLS"
  );

  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play & Win',
      home: HomePage(),
      /*initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => quizScreen(),
      },*/
    );
  }
}


