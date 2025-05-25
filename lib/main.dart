import 'package:flutter/material.dart';
import 'widgets/staticWidgets/navigationBottom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'session/sessionStatus.dart';
import 'screen/login.dart';
import 'screen/infoAccount.dart';
import 'screen/splashScreen.dart';
import 'screen/profile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هکس ارنا',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashscreenPage(),
        '/login': (context) => LoginPage(),
        '/account': (context) => ProfilePage(),
      },
    );
  }
}