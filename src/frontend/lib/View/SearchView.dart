import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../View/FilterView.dart';
import '../Model/ContextData.dart';
import '../View/LoginView.dart';
import '../Service/SkillsService.dart';
import '../View/ProfileView.dart';
import '../Service/SearchService.dart';
import '../Components/BottomNavBar.dart';
import '../Model/User.dart';

class SearchView extends StatefulWidget{

  final ContextData contextData;

  SearchView(this.contextData);

  @override
  createState() => new SearchViewState([], contextData);
}

class SearchViewState extends State<SearchView>{
  final TextEditingController _controllerPesquisa = new TextEditingController();
  List<User> users;
  List<User> allUsers;
  ContextData contextData;
  String searchedRole="";
  String searchedName="";
  bool loading;

  SearchViewState(List<User> users, ContextData contextData){
    this.contextData = contextData;
    this.users = [];
    this.loading = true;

    this.getAllUsers().then((allUsers) {
      this.setState(() {
        this.loading = false;
        this.allUsers = allUsers;
      });
    });

  }

  Future<List<User>> getAllUsers() {
    return new SearchService().getAllUsers(contextData.user);
  }

  List<User> getUsers(String name){
    List<User> filteredUsers;

    if(name != ""){
      filteredUsers = allUsers.where( (i) => i.name.contains(name)).toList();
      return filteredUsers;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mulambos dti',
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: [new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(24.0),
                child: new TextField(
                  style: new TextStyle(
                    color: const Color(0xffbebebe),
                    fontSize: 16.0,
                  ),
                  decoration: new InputDecoration(
                      hintText: 'Pesquisa',
                      prefixIcon:
                        new Icon(Icons.search, color: new Color(0xffbebebe)),
                      suffixIcon:
                        new IconButton(
                            icon: new Icon(Icons.filter_list),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new FilterView(contextData)),
                              );
                            },
                        ),
                  ),
                  controller: _controllerPesquisa,
                  onChanged: (text) {
                    setState(() {
                      searchedName = text;
                    });
                      users = getUsers(searchedName);
                  },
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 12.0,top: 10.0),
                    height: MediaQuery.of(context).size.height*0.72,
                    child: new ListView(
                      padding: new EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      children: new List.generate(users.length, (int index){
                        return new GestureDetector(
                          onTap: () {
                            setState(() { loading = true; });
                            new SkillsService().getUserSkills(contextData.user, users[index].id).then((skillsSearch) {
                              setState((){ loading = false; });
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new ProfileView(skillsSearch, users[index], contextData)));
                            });
                          },
                          child: new Container(
                            height: 52.0,
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                  height: 48.0,
                                  width: 48.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new AssetImage('assets/logo.png'),
                                      )
                                  ),
                                ),
                                new Expanded(
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                            margin: new EdgeInsets.only(top: 6.0),
                                            padding: new EdgeInsets.only(left: 16.0),
                                            child: new Text(
                                              users[index].name,
                                              style: new TextStyle(
                                                  color: const Color(0xff616161),
                                              fontSize: 16.0,
                                            ),
                                            ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          )
                        );
                      }),
                    ),
                  ),
                ],
              )
            ],
          ),
          loading ? new Container(
            child: new Center(
              child: new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: new Color(0xccffffff),
              ),
            ),
          ): new Container(),
          loading ? new LoadingCircleRotate(): new Container(),
          ]
        ),
        bottomNavigationBar: new BottomNavBar(contextData ,0),
      ),
    );
  }

}