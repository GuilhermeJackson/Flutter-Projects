import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  runApp(MyApp());
  // Esperando os dados para inserir no snapshot
  //DocumentSnapshot snapshot = await Firestore.instance.collection("menssagens").document("msg1").get();

  // Snapshot recebe uma foto exato do momento do banco
  //QuerySnapshot snapshot = await Firestore.instance.collection("menssagens").getDocuments();

  // Sempre que houver uma mudança, uma função é chamada
  Firestore.instance.collection("menssagens").snapshots().listen((snapshot){
    for (DocumentSnapshot doc in snapshot.documents) {
      print(doc.data);
    }
  });

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}