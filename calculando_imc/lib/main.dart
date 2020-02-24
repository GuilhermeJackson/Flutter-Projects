import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoTeste = "informe os seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Criando uma chave global
  void _resetField(){
    setState(() {
      weigthController.text = "";
      heightController.text = "";
      _infoTeste = "Informe seus dados!";
    });

  }
    void _calculate(){
    setState(() {   //usado para atualizar na tela
      double weigth = double.parse(weigthController.text);    //passando de texto para double
      double height = double.parse(heightController.text);    //passando de texto para double
      double imc = weigth / (height * height);
      print(weigth);
      print(height);
      print(imc);
      if(imc < 18.6){
        _infoTeste = "Abaixo do peso (${imc.toStringAsPrecision(3)})";    // toStringAsPrecision - usado para retornar um numero de 4 digito
      } else if (imc >= 18.6 && imc < 24.9){
          _infoTeste = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if (imc >= 24.9 && imc < 29.9){
        _infoTeste = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoTeste = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoTeste = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40.0){
        _infoTeste = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  //Scaffold - implementa barra inferior, barra superior, botão inferior lado direito e botao de mais no canto superior
      appBar: AppBar(title: Text("Calculadora de IMC"),
        centerTitle: true, //centralizando o titulo
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: () {_resetField();},)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child:Form(   //Criando um formulario
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,   //sempre tentara preencher a largura do q estiver na coluna
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(    //fala sobre o texto (Label) do TextField
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,    // Inserindo o numero no centro do TextField
                style: TextStyle(color: Colors.green, fontSize: 25.0),    //altarando o tamanho e a cor do texto digitado
                controller: weigthController,   //controller - passando informação para o TextField
                validator: (value) {  // TextFormField tem a função adicional 'validator' q recebe uma outra função anonimo
                  if(value.isEmpty) {
                    return "Insira o seu Peso";
                  }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(    //fala sobre o texto do TextField
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,    // Inserindo o numero no centro do TextField
                style: TextStyle(color: Colors.green, fontSize: 25.0),    //altarando o tamanho e a cor do texto digitado
                controller: heightController, // controller - passando informação para o TextField
                validator: (value) {   // TextFormField tem a função adicional 'validator' q recebe uma outra função anonimo
                  if(value.isEmpty) {
                    return "Insira o sua Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Container(    //Container é usado para aumentar o tamanho do botão
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {   // Verifica se o campo foi valido, pra entao chamar o _calculate()
                        _calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.green,
                  ),
                ),
              ),
              Text("$_infoTeste", textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0))
            ],
          ),
        )
      )
    );
  }
}
