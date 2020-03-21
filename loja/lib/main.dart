import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/HomeScreen.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/screens/sigup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      // tudo será modificado quando o UserModel for modificado tbm
      model: UserModel(),
        child: MaterialApp(
          title: "Loja online",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 150, 220)
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        )
    );
  }
}