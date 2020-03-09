import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      //pegando todas as categorias do firebase da coleção product
      future: Firestore.instance.collection("product").getDocuments(),
      builder: (context, snapshot) {
        //verifica se tem algo no firebase, se tiver retorna uma ListView
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else {
          return ListView(
            children: <Widget>[

            ],
          );
        }
      },
    );
  }
}
