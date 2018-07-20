import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Model/Skill.dart';
import '../View/BottomNavBar.dart';
import '../Model/User.dart';

class SearchView extends StatefulWidget{

  User user;
  List<Skill> skills;

  SearchView(user,skills){
    this.user = user;
    this.skills = skills;
  }

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

  SearchViewState(List<User> users, user,skills){
    this.users = this.getUsers();
    this.roles = this.getRoles();
    this.skills = skills;
    this.user = user;
  }

  List<User> getUsers({String role = "", String name = ""}){
    List<User> users = [
      new User(id: "1", name: "Lucas Hofner",role: "DEV"),
      new User(id: "2", name: "Fulano",role: "Design"),
      new User(id: "3", name: "Ciclano",role: "GP"),
      new User(id: "4", name: "Lucas Hofner",role: "DEV"),
      new User(id: "5", name: "Lucas Hofner",role: "DEV"),
      new User(id: "6", name: "Lucas Hofner",role: "DEV"),
      new User(id: "7", name: "Lucas Hofner",role: "Design"),
      new User(id: "8", name: "Lucas Hofner",role: "DEV"),
      new User(id: "9", name: "Lucas Hofner",role: "DEV"),
      new User(id: "10", name: "Lucas Hofner",role: "DEV"),
      new User(id: "11", name: "Lucas Hofner",role: "Outro"),
      new User(id: "12", name: "Lucas Hofner",role: "DEV"),
      new User(id: "13", name: "Lucas Hofner",role: "Outra"),
      new User(id: "14", name: "Lucas Hofner",role: "DEV"),
      new User(id: "15", name: "Lucas Hofner",role: "DEV"),
      new User(id: "16", name: "Lucas Hofner",role: "GP"),
      new User(id: "17", name: "Lucas Hofner",role: "DEV"),
    ];

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
            new Container(
              height: 40.0,
              padding: new EdgeInsets.symmetric(horizontal: 16.0),
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: new List.generate(roles.length, (int index) {
                  return new Container(
                    width: 104.0,
                    margin: new EdgeInsets.only(right: 8.0),
                    child: new FlatButton(
                      color: searchedRole == roles[index] ? const Color(0xff2db6c3) : Colors.white ,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(36.0),
                          side: new BorderSide(
                            color: const Color(0xff2db6c3),
                            width: 1.0,
                          )
                      ),
                      child: new Text(
                        roles[index] == "Design" ? roles[index]+"ers" : roles[index]+"s",
                        style: new TextStyle(
                            color: searchedRole == roles[index] ? Colors.white : const Color(0xff2db6c3), fontSize: 12.0
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          searchedRole = roles[index];
                        });
                        users = getUsers(role: searchedRole, name: searchedName);

                      },
                    ) ,
                  );
                }),
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
                          return new Container(
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
                                        new Container(
                                          margin: new EdgeInsets.only(top: 3.0),
                                          padding: new EdgeInsets.only(left: 16.0),
                                          child: new Text(
                                            users[index].role,
                                            style: new TextStyle(
                                              color: const Color(0xff616161),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
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