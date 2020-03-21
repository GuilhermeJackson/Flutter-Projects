import 'package:flutter/material.dart';
import 'package:loja/screens/HomeScreen.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/screens/sigup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loja online",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 150, 220)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}