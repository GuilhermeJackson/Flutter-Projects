import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    //se _search for null faz a requisição do melhores gifs, se não recebe a URL para pesquisar gifs por palavras chave
    if (_search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=LwgVtZil4WPnNkKLCXDNKTiyMtIQHSCw&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=LwgVtZil4WPnNkKLCXDNKTiyMtIQHSCw&q=$_search&limit=25&$_offset=25&rating=G&lang=en");
    return json.decode(response.body);
  }

  // Carregando as informações do app
  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Pesquise aqui...",
                    labelStyle: TextStyle(color: Colors.white),
                    border:
                        OutlineInputBorder() //iserindo a borda ao redor do textField
                    ),
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              )),
          Expanded(
            //Criando a grade de gifs q serao visualizados
            child: FutureBuilder(
                future: _getGifs(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          //Circulo girando ao carregar a pagina
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          //strokeWidth - passando o tamanho do circulo de carregar
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Center(
                            child: Text(
                          "Erro ao carregar os dados :(",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ));
                      else
                        return _createGifTable(context, snapshot);
                  }
                }),
          ),
        ],
      ),
    );
  }

  // Retonar esse widget caso a requisição da API der tudo certo ao carregar
  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      //gridDelegate - como os itens vao ser organizados na tela
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index){
        //GestureDetector - usado para conseguir abrir uma imagem
        return GestureDetector(
          child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300.0,
          fit: BoxFit.cover,),

        );
      },
    );
  }
}
