import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // Requisição de um modo que não precise esperar a requisição estar completa
import 'dart:convert'; //Usado para converte algo em Json

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=fcb552cb"; // URL da API

void main() async {
  //http.Response response = await http.get(request); //manda o get para o servido com a url do request e retorna quando os dados chegar do servidor
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);
  print("q?");
  print(await getData());
  runApp(MaterialApp(home: Home()));
}

Future<Map> getData() async {
  //fucao vindo do futuro
  http.Response response = await http.get(request);
  return
    json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {    //passando funcao anonima para especificar o q vai ser passado na tela
            switch (snapshot.connectionState) {   //usando switch para informa o status da conexão
              case ConnectionState.none:  //conexão: não determinada
              case ConnectionState.waiting: // conexão: esperando os cados
                return Center(    //Center - simplesmente centraliza os dados
                    child: Text(
                  "Carregando",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
              if(snapshot.hasError){    //Verifica se teve algum erro se a conexão não estiver no status none ou waiting e retorna uma mensagem
                return Center(    //Center - simplesmente centraliza os dados
                    child: Text(
                      "Erro ao carregar os dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
              } else {
                return Container(color: Colors.green);  //se não tiver erro, retorna esse else
              }
            }
          },
        )
    );
  }
}
