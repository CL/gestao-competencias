import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../View/FilterView.dart';
import '../Model/ContextData.dart';
import '../View/LoginView.dart';
import '../Service/SkillsService.dart';
import '../View/ProfileView.dart';
import '../Service/SearchService.dart';
import '../Model/User.dart';

class SearchView extends StatefulWidget{

  final ContextData contextData;
  final List<User> users;
  SearchView(this.contextData, { this.users });

  @override
  createState() => new SearchViewState(contextData, users);
}

class SearchViewState extends State<SearchView>{
  List<User> users;
  List<User> filteredUsers;
  ContextData contextData;
  String searchedName="";
  bool loading = false;
  TextEditingController _controllerText = new TextEditingController();

  SearchViewState(ContextData contextData, List<User> users){
    this.contextData = contextData;

    if(contextData.filteredUsers == null) {
      contextData.isAllUsers = true; 
      this.loading = true;
      this.users = users ?? [];
      this.getAllUsers().then((allUsers) {
        this.setState(() {
          this.loading = false;
          this.filteredUsers = allUsers;
        });
      });
    }
    else {
      this.filteredUsers = contextData.filteredUsers;
      this.users = contextData.isAllUsers ? [] : this.filteredUsers;
    }

  }

  Future<List<User>> getAllUsers() {
    return new SearchService().getAllUsers(contextData.user);
  }

  List<User> getUsers(String name){
    name = name.toLowerCase();
    List<User> matchingUsers;
    if(name != ""){
      matchingUsers = filteredUsers.where((i) => i.name.toLowerCase().contains(name)).toList();
      return matchingUsers;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new MaterialApp(
      title: 'Mulambos dti',
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Ex-Mulambos'),
        ),
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: [new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(width*0.03, height*0.02, width*0.03, 0.0),
                child: new TextField(
                  controller: _controllerText,
                  style: new TextStyle(
                    color: const Color(0xffbebebe),
                    fontSize: height*0.028,
                  ),
                  decoration: new InputDecoration(
                      hintText: 'Pesquisa',
                      prefixIcon:
                        new Icon(Icons.search, color: new Color(0xffbebebe)),
                      suffixIcon:
                        searchedName == "" ?
                        new IconButton(
                            icon: new Icon(Icons.filter_list, color: contextData.isAllUsers == true ? new Color(0xffbebebe): Colors.deepPurple),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new FilterView(contextData)),
                              );
                            },
                        ) :
                        new IconButton(
                            icon: new Icon(Icons.close),
                            onPressed: () {
                              setState((){ 
                                searchedName = "";
                                users = getUsers(searchedName);
                                _controllerText.text = "";
                              });
                            },
                        ),
                  ),
                  onChanged: (text) => setState(() {
                    searchedName = text;
                    users = getUsers(searchedName);
                  })
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: width*0.03,top: 18.0),
                    height: MediaQuery.of(context).size.height*0.69,
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
                            height: height*0.085,
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                  height: height*0.085,
                                  width: width*0.12,
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
                                            margin: new EdgeInsets.only(top: height*0.025),
                                            padding: new EdgeInsets.only(left: width*0.05),
                                            child: new Text(
                                              users[index].name,
                                              style: new TextStyle(
                                                  color: const Color(0xff616161),
                                              fontSize: height*0.028,
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
      ),
    );
  }

}