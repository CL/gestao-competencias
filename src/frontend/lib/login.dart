import 'package:flutter/material.dart';

import 'main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        body: new Container(
            padding: const EdgeInsets.symmetric(horizontal: 51.0),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage(
                        'assets/background--gradiente--texture.png'),
                    fit: BoxFit.cover)),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new Center(
                    child: new Image.asset('assets/brand---dti---negativa.png'),
                  ),
                ),
                new Theme(
                    data: theme.copyWith(
                        primaryColor: Colors.white,
                        hintColor: Colors.white30,
                        primaryIconTheme:
                            new IconThemeData(color: Colors.white)),
                    child: new Column(
                      children: <Widget>[
                        new TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                          decoration: new InputDecoration(
                              hintText: 'e-mail',
                              prefixIcon:
                                  new Icon(Icons.person, color: Colors.white)),
                        ),
                        new TextField(
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                          decoration: new InputDecoration(
                              hintText: 'senha',
                              prefixIcon: new Icon(Icons.lock_outline,
                                  color: Colors.white)),
                        ),
                      ],
                    )),
                new Expanded(
                  child: new Center(
                      child: new Container(
                          height: 48.0,
                          width: 258.0,
                          child: new RaisedButton(
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(36.0)),
                            child: new Text(
                              'ENTRAR',
                              style: new TextStyle(
                                  color: const Color(0xff5e529d),
                                  fontSize: 12.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new MyHomePage(
                                          title: 'Gestão de competências')));
                            },
                          ))),
                ),
              ],
            )),
      ),
    );
  }
}
