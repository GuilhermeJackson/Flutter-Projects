import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    //DefaultTabController = Definindo uma tabela de exibição padrão (terá duas opções de exibição)
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
            // exibindo as opções de exibições do produto
          bottom: TabBar(
            indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.grid_on),),
            Tab(icon: Icon(Icons.list),)
          ],
        ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("product").document(snapshot.documentID).collection("items").getDocuments(),
          builder: (context, snapshot){
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else
              return TabBarView(
                // physics: NeverScrollableScrollPhysics() = Usado para não arrastar a tela com dedo, apenas ao selecionar o icon(TabBar)
                //physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                      // passando a (quantidade / espassamento/ eixo cruzado) de itens do Grid na horizontal
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        // data.category = usado para passar a categoria do produto para o carrinho
                        data.category = this.snapshot.documentID;
                        return ProductTile("grid", data);

                      }
                      ),

                  ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {

                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        // data.category = usado para passar a categoria do produto para o carrinho
                        data.category = this.snapshot.documentID;
                        return ProductTile("list", data);
                      }),
                ],
              );
          },
        ),
      ),
    );
  }
}
