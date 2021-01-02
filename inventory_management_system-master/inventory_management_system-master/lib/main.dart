import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/Scanner.dart';
import 'package:inventory_management_system/Screens/details_screen.dart';
import 'package:inventory_management_system/Screens/login.dart';
import 'package:inventory_management_system/Screens/signup.dart';
import 'package:inventory_management_system/Screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen()
    );
  }
  getStringValuesSF(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = await prefs.getString(data.toString()) ?? 'blank value';
    return stringValue;
  }

  addStringToSF(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key.toString(), value.toString());
  }
}



