import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Service/SkillsService.dart';
import '../View/ProfileView.dart';
import '../Service/SearchService.dart';
import '../Model/Skill.dart';
import '../Components/BottomNavBar.dart';
import '../Model/User.dart';

class SearchView extends StatefulWidget{

  final User user;
  final List<Skill> skills;

  SearchView(this.user, this.skills);

  @override
  createState() => new SearchViewState([],this.user,this.skills);
}

class SearchViewState extends State<SearchView>{
  final TextEditingController _controllerPesquisa = new TextEditingController();
  User user;
  List<User> users;
  List<Skill> skills;
  List<String> roles;
  String searchedRole="";
  String searchedName="";

  SearchViewState(List<User> users, User user, List<Skill> skills){
    this.user = user;
    this.roles = this.getRoles();
    this.skills = skills;
    this.users = [];
    this.getAllUsers().then((allUsers) {
      this.setState(() => this.users = allUsers);
    });
  }

  Future<List<User>> getAllUsers() {
    return new SearchService().getAllUsers(user);
  }

  List<User> getUsers({String role = "", String name = ""}){
    List<User> filteredUsers;
    List<User> doubleFilteredUsers;
    if(role != "" && name == ""){
      filteredUsers = users.where((i) => i.role == role).toList();
      return filteredUsers;
    }else if(role != "" && name != ""){
      filteredUsers = users.where((i) => i.role == role).toList();
      doubleFilteredUsers = filteredUsers.where((i) => i.name.contains(name)).toList();
      return doubleFilteredUsers;
    }else if( role == "" && name != ""){
      filteredUsers = users.where( (i) => i.name.contains(name)).toList();
      return filteredUsers;
    }

    return users;
  }

  List<String> getRoles(){
    List<String> roles = [
      "Design",
      "DEV",
      "GP",
      "Outro",
      "Outra",
    ];
    return roles;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mulambos dti',
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Column(
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
                    new Icon(Icons.search, color: new Color(0xffbebebe))),
                    controller: _controllerPesquisa,
                    onChanged: (text) {
                        setState(() {
                          searchedName = text;
                        });
                        users = getUsers(role: searchedRole, name: searchedName);
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
                          new SkillsService().getUserSkills(user, users[index].id).then((skills) {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ProfileView(skills, users[index])));
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
        bottomNavigationBar: new BottomNavBar(this.user,this.skills,1),
      ),
    );
  }

}