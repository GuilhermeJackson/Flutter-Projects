import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    //Nesse caso é usado Material para ocorrer o efeito ao clicar nos textos do drawler
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(icon,
              size: 32.0,
              color: Colors.black,
              ),
              SizedBox(width: 32.0,),
              Text(text, style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).primaryColor
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
