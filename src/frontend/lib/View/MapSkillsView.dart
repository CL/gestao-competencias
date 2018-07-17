import 'dart:collection';

import 'package:flutter/material.dart';

import '../Model/Skill.dart';

import '../Shared/global.dart' as globals;
import 'MapSubSkillsView.dart';


class MapSkillsView extends StatefulWidget {
  MapSkillsView({Key key}) : super(key: key);

  @override
  createState() => new MapSkillsState();
}

class MapSkillsState extends State<MapSkillsView>{
  HashMap<String, bool> selectedSkillsIds = new HashMap();

  List<Skill> skills;

  MapSkillsState(){
    skills = getAllSkills();
  }

  List<Skill> getAllSkills(){
    List<SubSkill> subSkills = [
      new SubSkill(subSkillName: ".Net C", subSkillRating: 5.0, subSkillId: "1"),
      new SubSkill(subSkillName: ".Net C#", subSkillRating: 4.0, subSkillId: "2"),
      new SubSkill(subSkillName: ".Net VB", subSkillRating: 3.0, subSkillId: "3"),
      new SubSkill(subSkillName: "Java", subSkillRating: 2.0, subSkillId: "4"),
      new SubSkill(subSkillName: "C++", subSkillRating: 1.0, subSkillId: "5"),
      new SubSkill(subSkillName: "Python", subSkillRating: 0.0, subSkillId: "6"),
    ];

    List<Skill> allSkills = [
      new Skill(skillName: "LINGUAGENS", skillId: "1", skillRating: 2.0, subSkills: subSkills, totalSubSkills: 6),
      new Skill(skillName: "LINGUAGENS 2", skillId: "2", skillRating: 0.0, subSkills: subSkills, totalSubSkills: 6),
      new Skill(skillName: "LINGUAGENS 3", skillId: "3", skillRating: 0.0, subSkills: subSkills, totalSubSkills: 6),
      new Skill(skillName: "LINGUAGENS 3", skillId: "4", skillRating: 0.0, subSkills: subSkills, totalSubSkills: 6)
    ];

    return allSkills;
  }

  @override
  Widget build(BuildContext context) {
    skills.forEach((skill){
      selectedSkillsIds.putIfAbsent(skill.skillId, () => false);
    });

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
        child: new Scrollbar(
          child: new CustomScrollView(
            shrinkWrap: true,
            slivers: [new SliverList(
              delegate: new SliverChildListDelegate(
                getSkillsList()
              ),
            )],
          ),
        ) 
      ),
    );
  }

  void save(){
    List<Skill> selectedSkills = [];
    selectedSkillsIds.forEach((key, value) {
      if(value){
        selectedSkills.add(skills.firstWhere((element) => element.skillId == key));
      }
    });
    globals.selectedSkills = selectedSkills;

    Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new MapSubSkillsView(selectedSkills)));
  }

  List<Widget> getSkillsList(){
    List<Widget> newWidgets = [];
    newWidgets.add(new Text(
      "Selecione as habilidades que você tem domínio de acordo com as skills listadas.",
      style: new TextStyle(
        color: new Color.fromRGBO(97, 97, 97, 1.0),
        fontSize: 14.0
      ),
    ));
    skills.forEach((skill){
      newWidgets.add(
        new Container(
          padding: new EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
          child: new Card(
            child: new Container(
              padding: new EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 15.0),
              child: new Column(
                children: [
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      new Text(
                        skill.skillName,
                        style: new TextStyle(
                          color: new Color.fromRGBO(45, 182, 195, 1.0),
                          fontSize: 16.0
                        ),
                      ),
                      new Checkbox(
                        value: selectedSkillsIds[skill.skillId], 
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (value){
                          setState((){
                            selectedSkillsIds[skill.skillId] = value;
                          });
                        },
                      )
                    ],
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
                  ),
                  new Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: getChipsSubSkills(skill.subSkills)
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

  List<Widget> getChipsSubSkills(List<SubSkill> subSkills){
    List<Widget> chips = [];

    subSkills.forEach((subSkill) {
      chips.add(
        new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(36.0)),
            border: new Border.all(color: new Color.fromARGB(255, 190, 190, 190))
          ),
          child: new Chip(
            label: new Text(
              subSkill.subSkillName,
              style: new TextStyle(
                fontSize: 12.0,
                color: new Color.fromRGBO(97, 97, 97, 1.0)
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        )
      );
    });
    return chips;
  }
}