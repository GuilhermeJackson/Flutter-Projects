import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  runApp(MyApp());
  // Esperando os dados para inserir no snapshot
  //DocumentSnapshot snapshot = await Firestore.instance.collection("menssagens").document("msg1").get();

  // Snapshot recebe uma foto exato do momento do banco
  //QuerySnapshot snapshot = await Firestore.instance.collection("menssagens").getDocuments();

  // Sempre que houver uma mudança, uma função é chamada
  Firestore.instance.collection("menssagens").snapshots().listen((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      print(doc.data);
    }
  });


}


class MyApp extends StatelessWidget {


//Definindo a cor padrão de varios componentes
  final ThemeData KIOSTheme = ThemeData(
      primarySwatch: Colors.orange,
      //Tonalidade
      primaryColor: Colors.grey[300],
      //Brilho
      primaryColorBrightness: Brightness.light);

//Definindo a cor padrão de varios componentes
  final ThemeData KDefaultTheme = ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Nem a NASA rastreia...",
      // Remover a faixa de debug da tela do app
      debugShowCheckedModeBanner: false,
      // Define um tema se for iphone e outro tema se for android
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? KIOSTheme
          : KDefaultTheme,
      home: ChatScreen(),
    );
  }

}

// usado para pegar o usuario atualo do google
final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance;

// Verifica se o usuario está logado
Future<FirebaseUser> _ensureLoggedIn() async {
  // Pegando usuario atual do google
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null)
    // dar login sem o usuario ver caso ele ja tenha logado alguma vez
    user = await googleSignIn.signInSilently();

  if (user == null)
    // Solicitar o login do google para o usuário
    user = await googleSignIn.signIn();

    //Verifica se o usuario do fireBase é null, e autentica o usuario no firebase (é necessario estar logado no fireBase e google)
  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credencials = await googleSignIn.currentUser.authentication;
    //auth.signInWithGoogle(idToken: credencials.idToken, accessToken: credencials.accessToken); (usado em versões anteriores)
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: credencials.accessToken,
      idToken: credencials.idToken,
    );
    final FirebaseUser user = (await auth.signInWithCredential(credential)) as FirebaseUser;
    print("signed in " + user.displayName);
    return user;
  }
}

_handleSubmitted(String text) async{
  await _ensureLoggedIn();
  _sendMesage(text: text);
}

// funcao com parametros opicionais usado os { }
void _sendMesage({String text, String imgURL}){
  //Pega o dado da mensagem e manda para o FireBase
  Firestore.instance.collection("messages").add(
    {
      "text" : text,
      "imgUrl" : imgURL,
      // Pegando o nome do usuario atraves do google
      "senderName" : googleSignIn.currentUser.displayName,
      "senderPhotoUrl" : googleSignIn.currentUser.photoUrl
    }
  );
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // SafeArea - ignora as barrinhas do iPhone e android (barra com botao de voltar e minimizar os app e tal)
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat App"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[ChatMessage(), ChatMessage(), ChatMessage()],
              ),
            ),
            Divider(
              height: 2.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  //usado cara verificação de login
  bool _isComposing = false;
  //usado para pegar informações do textField
  final _textController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        // Inserir o const no na margin, deixa o app mais leve
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration.collapsed(
                    hintText: "Escreva sua mensagem..."),
                onChanged: (text) {
                  setState(() {
                    // se o meu texto tiver mais q 0 caracteres ele vai estar compondo
                    _isComposing = text.length > 0;
                  });
                },
                // Enviando mensagem pelo enter do teclado do celular
                onSubmitted: (text) {
                  _handleSubmitted(text);
                },
              ),
            ),

            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("Enviar"),
                        onPressed: _isComposing ? () {
                          _handleSubmitted(_textController.text);
                        } : null,
                      )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing ? () {
                          _handleSubmitted(_textController.text);
                        } : null,
                      )),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.dicionariopopular.com/imagens/stonks-og.jpg"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Daniel",
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text("teste"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
