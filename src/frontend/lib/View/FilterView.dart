import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../View/HomeAppView.dart';
import '../View/LoginView.dart';
import '../Service/SearchService.dart';
import '../Model/User.dart';
import '../Model/Skill.dart';
import '../Model/ContextData.dart';

class FilterView extends StatefulWidget{
  final ContextData contextData;
  final List<User> users;
  final List<User> filteredUsers;

  FilterView(this.contextData);

  @override
  createState() => new FilterState(contextData);
}

class FilterState extends State<FilterView>{
  ContextData contextData;
  Skill selectedSkill;
  SubSkill selectedSubSkill;
  bool loading = false;

  FilterState(this.contextData);

  Future<List<User>> getUsersCategory() {
    return new SearchService().getUsersCategory(contextData.user, selectedSubSkill);
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Gestão de Skills',
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
            title: Text('Filtro'),
            backgroundColor: Colors.cyan,
            leading: new IconButton(
                icon: new Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: new Stack(
          children: [
            new Column(
              children: [
                new Container(
                  padding: new EdgeInsets.only(right: width*0.78, top: height*0.03),
                  child: new Text(
                    'SKILLS',
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 1.0),
                      fontSize: height*0.028,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.only(left: width*0.04),
                      child: Icon(Icons.equalizer, color: selectedSkill != null ? Colors.deepPurple : const Color(0xffbebebe)),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(width*0.035),
                      width: width*0.8,
                      child: new DropdownButtonHideUnderline(
                        child: new ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton<Skill>(
                            onChanged: (item) {
                              setState(() {
                                selectedSkill = item;
                                selectedSubSkill = null;
                              });
                            },
                            value: selectedSkill,
                            items: getSkillsList(),
                            hint: new Container(
                              //padding: new EdgeInsets.fromLTRB(width*0.1, 0.0, width*0.41, 0.0),
                              child: new Text('Escolher', textScaleFactor: 1.0),
                            ),
                            iconSize: width*0.076,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Container(
                  padding: new EdgeInsets.only(right: width*0.74, top: height*0.03),
                  child: new Text(
                    'DOMÍNIO',
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 1.0),
                      fontSize: height*0.028,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.only(left: width*0.04),
                      child: new Icon(Icons.show_chart, color: selectedSubSkill != null ? Colors.deepPurple : const Color(0xffbebebe)),
                    ),
                    new Container(
                      margin: new EdgeInsets.all(width*0.035),
                      width: width*0.8,
                      child: new ButtonTheme(
                        alignedDropdown: true,
                        child: new DropdownButton<SubSkill>(
                          onChanged: (item) {
                            setState(() => selectedSubSkill = item);
                          },
                          value: selectedSubSkill,
                          items: selectedSkill!=null?getSubSkillsList(selectedSkill.subSkills): [],
                          hint: new Container(
                            padding: selectedSkill!=null?EdgeInsets.all(0.0): EdgeInsets.only(bottom: 13.0),
                            child: new Container(
                              padding: new EdgeInsets.only(right: width*0.51),
                              child: new Text('Escolher', textScaleFactor: 1.0),
                            ),
                          ),
                          iconSize: width*0.076,
                        ),
                      )
                    ),
                  ],
                ),
                new Expanded(child: new Container(),),
                new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Container(
                    padding: EdgeInsets.all(13.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ButtonTheme(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(width*0.35)
                          ),
                          minWidth: width*0.45,
                          height: height*0.09,
                          child: new RaisedButton(
                            elevation: 0.0,
                            child: new Text('LIMPAR FILTROS'),
                            textColor: Colors.deepPurple,
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                selectedSkill = null;
                                selectedSubSkill = null;
                              });
                            },
                          ),
                        ),
                        new ButtonTheme(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(width),
                          ),
                          minWidth: width*0.45,
                          height: height*0.09,
                          child: new RaisedButton(
                            elevation: 0.0,
                            child: new Text('APLICAR'),
                            textColor: Colors.white,
                            color: Colors.deepPurple,
                            onPressed:  filterUsers,
                          ),
                        ),
                      ],
                    )
                ),
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
          ],
        ),
      ),
    );
  }

  void filterUsers() {
    setState(() => loading = true);
    if(selectedSubSkill != null) {
      this.getUsersCategory().then((usersCategory) {
        this.setState(() {
          setState(() => loading = false);
          this.contextData.filteredUsers = usersCategory;
          this.contextData.isAllUsers = false;
          Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new HomeAppView(contextData, selectedTab: 0),
          ));
        });
      });
    } else {
      new SearchService().getAllUsers(contextData.user).then((allUsers) {
        setState(() => loading = false);
        this.contextData.filteredUsers = allUsers;
        this.contextData.isAllUsers = true;
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new HomeAppView(contextData, selectedTab: 0),
        ));
      });
    }

  }

  List<Widget> getSkillsList(){
    List<DropdownMenuItem<Skill>> newTextSkill = [];
    contextData.allSkills.forEach((skill){
      newTextSkill.add(
        new DropdownMenuItem<Skill>(
            child: new Text(skill.skillName),
            value: skill
        ),
      );
    });
    return newTextSkill;
  }

  List<Widget> getSubSkillsList(List<SubSkill> subSkills){
    List<DropdownMenuItem<SubSkill>> newTextSubSkill = [];
    subSkills.forEach((subSkill){
      newTextSubSkill.add(
        new DropdownMenuItem<SubSkill>(
            child: new Text(subSkill.subSkillName),
            value: subSkill
        ),
      );
    });
    return newTextSubSkill;
  }
}
