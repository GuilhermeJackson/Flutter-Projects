import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/tiles/category_tile.dart';

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
          // Pega todo o documento, transforma em uma CategoryTile, e transforma em uma lista
          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data.documents.map((doc) {
                return CategoryTile(doc);
              }).toList(),
              color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
