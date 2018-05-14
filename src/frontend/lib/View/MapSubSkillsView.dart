import 'package:flutter/material.dart';

import '../Model/Skill.dart';


class MapSubSkillsView extends StatefulWidget {
  List<Skill> skills;
  
  MapSubSkillsView(this.skills, {Key key}) : super(key: key);

  @override
  createState() => new MapSubSkillsState(skills);
}

class MapSubSkillsState extends State<MapSubSkillsView>{
  List<Skill> skills;

  MapSubSkillsState(this.skills);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mapear Skills"),
        actions: [
          new IconButton(
            onPressed: save,
            icon: new Icon(Icons.save)
          )
        ],
        leading: new Icon(Icons.arrow_back),
      ),
      body: new Container(
        padding: new EdgeInsets.all(18.0),
        child: new Column(
          children: getSubSkillsList()
        ),
      ),
    );
  }

  void save(){

  }

  List<Widget> getSubSkillsList(){
    List<Widget> newWidgets = [];
    newWidgets.add(new Column(
      children: [
        new Text(
          "Classifique seu domínio nas skills.",
          style: new TextStyle(
            color: new Color.fromRGBO(97, 97, 97, 1.0),
            fontSize: 14.0
          ),
        ),
        new Text(
          "Dê like nas quais tem interesse em aprender.",
          style: new TextStyle(
            color: new Color.fromRGBO(97, 97, 97, 1.0),
            fontSize: 14.0
          ),
        ),
      ],
    ));

    skills.forEach((skill){
      newWidgets.add(
        new Container(
          padding: new EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: new Card(
            child: new Container(
              padding: new EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
              child: new Column(
                children: [
                  new Text(
                    skill.skillName,
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 1.0),
                      fontSize: 16.0
                    ),
                  ),
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                        child: new Text(
                          "Skills dessa categoria",
                          style: new TextStyle(
                            color: new Color.fromRGBO(97, 97, 97, 1.0),
                            fontSize: 10.0
                          ),
                        ),
                      )
                    ]
                  )
                ],
              ) 
            ),
          ),
        ),
      );
      
    });

    return newWidgets;
  }

}