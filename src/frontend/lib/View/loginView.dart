import 'package:flutter/material.dart';

import '../ViewModel/loginViewModel.dart';
import '../main.dart';
import 'MapSkillsView.dart';


LoginViewModel _loginViewModel = new LoginViewModel();

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
            padding: const EdgeInsets.symmetric(horizontal: 51.0),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage(
                        'assets/background--gradiente--texture.png'),
                    fit: BoxFit.cover)),
            child: new LoginInput()),
      ),
    );
  }
}

class LoginInput extends StatefulWidget {
  LoginInput({Key key}) : super(key: key);

  @override
  _LoginInputState createState() => new _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerSenha = new TextEditingController();
  final snackBarError = new SnackBar(
    content: new Text('Email ou senha incorretos. Você só pode errar a senha por 3 vezes ou seu login será bloqueado.'), 
    duration: new Duration(seconds: 3)
  );
  bool logingIn = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new Column(
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
                primaryIconTheme: new IconThemeData(color: Colors.white)),
            child: new Column(
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      hintText: 'e-mail',
                      prefixIcon: new Icon(Icons.person, color: Colors.white)),
                  controller: _controllerEmail,
                ),
                new TextField(
                  obscureText: true,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      hintText: 'senha',
                      prefixIcon:
                          new Icon(Icons.lock_outline, color: Colors.white)),
                  controller: _controllerSenha,
                ),
              ],
            )),
        new Expanded(
          child: new Center(
            child: new Container(
              height: 48.0,
              width: 258.0,
              child: logingIn == false ? 
              new RaisedButton(
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(36.0)
                ),
                child: new Text(
                  'ENTRAR',
                  style: new TextStyle(
                      color: const Color(0xff5e529d), fontSize: 12.0
                  ),
                ),
                onPressed: () {
                  setState(() { logingIn = true;} );
                  _loginViewModel.logIn(_controllerEmail.text, _controllerSenha.text)
                        .catchError(() {setState(() { logingIn = false;} );})
                        .then(logInUser);
                },
              ) : new RaisedButton(
                onPressed: (){},
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(36.0)
                ),
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    const Color(0xff5e529d)
                  ),
                )
              )
            )
          ),
        ),
      ],
    );
  }

  void logInUser(bool loginValido){
    setState(() { logingIn = false;} );
    if(loginValido){
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new MapSkillsView()));
    }
    else{
      Scaffold.of(context).showSnackBar(snackBarError);
    }
  }
}
