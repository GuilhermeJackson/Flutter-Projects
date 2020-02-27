import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {

  runApp(MyApp(

  ));
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection("menssagens").document().setData({"from": "Daniel", "texto":"Olá"});
    return Container();
  }
}