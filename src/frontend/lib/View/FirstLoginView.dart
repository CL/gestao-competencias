import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../View/HomeAppView.dart';
import '../Model/ContextData.dart';

class FirstLoginView extends StatefulWidget {
  final ContextData context;

  FirstLoginView(this.context);

  @override
  createState() => new FirstLoginState(context);
}

class FirstLoginState extends State<FirstLoginView>{

  ContextData contextData;

  FirstLoginState(this.contextData);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return new MaterialApp(
      title: 'Gestão de Skills',
      home: new Scaffold(
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(width*0.1, height * 0.176, width*0.1, height * 0.0625),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Image.asset('assets/logo.png'),
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, height * 0.075),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, height * 0.0375),
                      child: new Text(
                        'Olá ' + contextData.user.name,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: new Color(0xff616161),
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    new Container(
                        margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, height * 0.0375),
                        child: new Text(
                          'Informe quais habilidades você possui e quais você ainda '
                              'não tem domínio, mas tem interesse em aprender.',
                          style: new TextStyle(
                            color: new Color(0xff616161),
                            fontSize: 16.0,
                          ),
                        )
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, height * 0.0375),
                      child: new Text('Reserve 5 minutos para iniciar o mapeamento das suas '
                          'skills.',
                        style: new TextStyle(
                          color: new Color(4284572001),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, height * 0.075),
                      child: new Text('É importante manter seu perfil sempre atualizado.',
                        style: new TextStyle(
                          color: new Color(4284572001),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    new Container(
                    height: height*0.058,
                    width: width*0.8,
                        child: new RaisedButton.icon(
                          icon: new Icon(Icons.arrow_forward, color:const Color(0xff5e529d) ,),
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(width),
                              side: new BorderSide(
                                color: const Color(0xff5e529d),
                                width: 1.0,
                              )
                          ),
                          label: new Text(
                            'VAMOS COMEÇAR?',
                            style: new TextStyle(
                                color: const Color(0xff5e529d), fontSize: 16.0
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new HomeAppView(contextData, selectedTab: 1)));
                          },
                        )
                    ),
                  ],
                ),
              )
            ],
          )


      ),
    );
  }
}
