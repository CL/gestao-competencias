import 'package:flutter/material.dart';
import '../View/FirstLoginView.dart';

import '../Model/Skill.dart';
import '../Model/User.dart';
import '../Service/LoginService.dart';
import '../Service/SkillsService.dart';

import 'ProfileView.dart';


LoginService _loginViewModel = new LoginService();

class LoginView extends StatelessWidget {
  LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
            padding: MediaQuery.of(context).viewInsets,
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
  bool wrongPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new Stack(
      children: <Widget>[
        new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints ){
            return new SingleChildScrollView(
              child: new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(51.0, 113.0, 51.0, 104.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(bottom: 71.0),
                        child: new Image.asset('assets/brand---dti---negativa.png'),
                      ),
                      new Theme(
                          data: theme.copyWith(
                              primaryColor: Colors.white,
                              hintColor: Colors.white30,
                              primaryIconTheme: new IconThemeData(color: Colors.white)),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                margin: const EdgeInsets.only(bottom: 69.0),
                                child: new Text(
                                  'Entre com o mesmo login do NetSuite.',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),

                              new Container(
                                  margin: const EdgeInsets.only(bottom: 43.0),
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(bottom: 32.0),
                                        child: new TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          style: new TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: new InputDecoration(
                                              hintText: 'e-mail',
                                              prefixIcon: new Icon(Icons.person, color: Colors.white)),
                                          controller: _controllerEmail,
                                        ),
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
                                  )


                              ),
                            ],
                          )),
                      new Container(
                          height: 48.0,
                          width: 258.0,
                          child: new RaisedButton(
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
                              debugPrint("Senha: " + _controllerSenha.text);
                              debugPrint("Senha URL encode: " + Uri.encodeQueryComponent(_controllerSenha.text));
                              _loginViewModel.logIn(_controllerEmail.text, _controllerSenha.text)
                                  .catchError(() {setState(() { logingIn = false;} );})
                                  .then(logInUser);
                            },
                          )
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        logingIn == true ? new Container(
          child: new Center(
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: new Color(0xccffffff),
            ),
          ),
        ): new Container(),
        logingIn == true ? new LoadingCircleRotate(
        ): new Container(),
      ],
    );
  }

  void logInUser(User user){
    if(user != null){
      new SkillsService().getUserSkills(user).then((List<Skill> skills){
        setState(() { logingIn = false;} );
        if(skills.length == 0) {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new FirstLoginView(user)));
        } else {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ProfileView(skills, user)));
        }
        
      });

      
    }
    else{
      setState(() { logingIn = false;} );
      debugPrint("Erro");
      Scaffold.of(context).showSnackBar(snackBarError);
    }
  }
}

class LoadingCircleRotate extends StatefulWidget {
  @override
  _LoadingCircleRotateState createState() => new _LoadingCircleRotateState();
}

class _LoadingCircleRotateState extends State<LoadingCircleRotate>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1600),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: animationController,
        child: new Container(
          height: 48.0,
          width: 48.0,
          child: new Image.asset('assets/loadingCircle-xhdpi.png'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            angle: animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}
