import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        body: new Center(
          child: new Container(
            padding: new EdgeInsets.all(25.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Image.asset('assets/logo.png'),
                  padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 48.0),
                ),
                new Container(
                  child: new Text(
                    'Olá Vitor Rodarte',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: new Color(4284572001),
                      fontSize: 24.0,
                    ),
                  ),
                ),
                new Text(
                    'Informe quais habilidades você possui e quais você ainda '
                    'não tem domínio, mas tem interesse em aprender.',
                  style: new TextStyle(
                    
                  ),
                ),
                new Text('Reserve 5 minutos para iniciar o mapeamento das suas '
                    'skills.'),
                new Text('É importante manter seu perfil sempre atualizado.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
