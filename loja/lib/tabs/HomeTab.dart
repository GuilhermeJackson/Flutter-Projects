import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    *  @_BuildBodyBack - carrega a grade para visualização das imagens
    *
    * */
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 118, 230),
              Color.fromARGB(255, 253, 111, 0)
            ],
            begin: Alignment.topLeft,
                end: Alignment.bottomRight
          )),
        );

    // Stack - usado quando quer colocar alguma coisa em cima da outra
    return Stack(
      children: <Widget>[
        //Realizando o degrade do Container
        _buildBodyBack(),
        // Criando barra do top (fica um tempo fixado após rolar o mesmo para baixo)
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else {
                  print(snapshot.data.documents.length);
                    return SliverToBoxAdapter(
                      child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Container()
                  ),
                    );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
