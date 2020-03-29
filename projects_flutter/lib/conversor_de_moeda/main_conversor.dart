import 'package:flutter/cupertino.dart';
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
  runApp(MaterialApp(home: HomeConversor(),
    theme: ThemeData(   //Definindo tema para o app inteiro
        hintColor: Colors.amber,
        primaryColor: Colors.white
    ),
  ));
}

Future<Map> getData() async {
  //fucao vindo do futuro
  http.Response response = await http.get(request);
  return
    json.decode(response.body);
}

class HomeConversor extends StatefulWidget {
  @override
  _HomeConversorState createState() => _HomeConversorState();
}

class _HomeConversorState extends State<HomeConversor> {

  final realController = TextEditingController();   //Controlador do Real
  final dolarController = TextEditingController();   //Controlador do dolar
  final euroController = TextEditingController();   //Controlador do euro

  double dolar;
  double euro;
  void _realChanged(String text){
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

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
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView( //se não tiver erro, retorna esse else
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),

                        buildTextFild("Reais", "R\$", realController, _realChanged),

                        Divider(),  //Cria espaçamento entre os TextFileds

                        buildTextFild("Dolares", "US\$", dolarController, _dolarChanged),

                        Divider(),//Cria espaçamento entre os TextFileds

                        buildTextFild("Euro", "€", euroController, _euroChanged),

                      ],
                    ),
                  );
                }
            }
          },
        )
    );
  }
}

Widget buildTextFild(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber, fontSize: 18.0),
        border: OutlineInputBorder(),
        prefixText: prefix
    ),
    style: TextStyle(
        color: Colors.amber, fontSize: 25.0
    ),
    onChanged: f, //sempre q tiver alguma alteração no campo, é chamado a função f (identifica quando texto é alterado)
    keyboardType: TextInputType.number,
  );
}