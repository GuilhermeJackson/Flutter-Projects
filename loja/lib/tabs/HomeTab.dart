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
            )
          ],
        )
      ],
    );
  }
}
