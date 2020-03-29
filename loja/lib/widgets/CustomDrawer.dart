import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 150, 236, 255),
                Color.fromARGB(220, 253, 111, 0)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Flutter's\n Beers",
                      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),),

                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Se estiver logado mostra nome do Usuario, se não mostra nada
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"] }",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                // Se estiver logado mostra text sair, senão entre ou cadastre-se
                                child: Text(!model.isLoggedIn() ? "Entre ou cadastre-se >" : "sair",
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if(!model.isLoggedIn())
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=> LoginScreen())
                                  );
                                  else
                                    model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              // insere uma linha na tela
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Cervejas", pageController, 1),
              DrawerTile(Icons.location_on, "Bares", pageController, 2),
              DrawerTile(Icons.home, "Meus pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
