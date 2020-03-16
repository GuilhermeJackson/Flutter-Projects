import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  // Pega as categorias
  final DocumentSnapshot snapshot;
  // Deve ser passado um documento snapshot
  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading = icone localizado na esquerda da celula da ListView
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        // pegando a imagem do banco de dados
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"], style: TextStyle(color: Theme.of(context).primaryColor),),
      // trailing = setinha localizado a direita do titulo da categoria
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        // Passando para tela da categoria selecinada
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot))
        );
      },
    );
  }
}
