import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas.",
      home:Home()));
}

//Stateful é que vai ser desenhado na tela e podem ser mudado (parte de cima)
//StateLass é que vai ser desenhado na tela e nunca vao mudar (parte da classe Home)

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _peaple = 0;
  String _infoText = "Pode Entrar!!!";

  //metodo de incremento e decremento de _people e alteração de texto
  void _changePeople(int delta) {
    setState(() {
      _peaple += delta;

      if (_peaple < 0){
        _infoText = "Mundo invertido?!";
      } else if (_peaple <= 10 ) {
        _infoText = "Pode Entrar!!!";
      } else {
        _infoText = "Ta lotado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Stack é usado para sobre por algum widget sobre outro widget
      children: <Widget>[
        Image.asset(
          "images/jontas.png",
          //busca a imagem do "pubspec.taml" -> asset q foi instanciada lá
          fit: BoxFit.cover,
          //usado para informar como a imagem será exibida (no caso será a tela inteira)
          height: 1000.0,
          width: 500.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //alinha o texto centro verticalmente
          children: <Widget>[
            Text(
              "Pessoas: $_peaple",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              //usando para os botoes ficarem na horizontal (dentro de uma colunm vertical)
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  //dando espaçamento para todos os lados do botao
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    //child permite apenas um filho || children permite varios filhos
                    onPressed: () { _changePeople(1); }, //funcao q o botao vai chamar quando clicado
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    //child permite apenas um filho || children permite varios filhos
                    onPressed:
                        () { _changePeople(-1);}, //funcao q o botao vai chamar quando clicado
                  ),
                ),
              ],
            ),
            Text(_infoText,
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0))
          ],
        ) // especificando a tela incial do app
      ],
    );
  }
}






