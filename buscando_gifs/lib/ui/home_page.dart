import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String urlDogs = "https://api.giphy.com/v1/gifs/search?api_key=el7kQVP1iP9GwTZCCObxvOZ91QDHphGn&q=dogs&limit=20&offset=25&rating=G&lang=en";
  final String urlTendencias = "https://api.giphy.com/v1/gifs/trending?api_key=el7kQVP1iP9GwTZCCObxvOZ91QDHphGn&limit=20&rating=G";
  String _search;
  int _offset = 0;

  Future<Map>_getGifs() async {
    http.Response response;

    //se _search for null faz a requisição do melhores gifs, se não recebe a URL para pesquisar gifs por palavras chave
    if (_search == null){
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=el7kQVP1iP9GwTZCCObxvOZ91QDHphGn&limit=20&rating=G");
    } else {
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=el7kQVP1iP9GwTZCCObxvOZ91QDHphGn&q=$_search&limit=20&offset=$_offset&rating=G&lang=en");
      return json.decode(response.body);
    }
  }

  // Carregando as informações do app
  @override
  void initState() {
    super.initState();
    _getGifs().then((map){
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
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
                    border: OutlineInputBorder()    //iserindo a borda ao redor do textField
                ),
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              )
          )
        ],
      ),
    );
  }
}
