import 'dart:collection';

import 'package:flutter/material.dart';

import '../Model/ContextData.dart';
import '../Service/SkillsService.dart';
import '../Components/BottomNavBar.dart';
import '../Model/User.dart';
import '../Model/Skill.dart';
import 'MapSubSkillsView.dart';


class MapSkillsView extends StatefulWidget {
  final ContextData contextData;
  
  MapSkillsView(this.contextData, {Key key}) : super(key: key);

  @override
  createState() => new MapSkillsState(contextData);
}

class MapSkillsState extends State<MapSkillsView>{
  HashMap<String, bool> selectedSkillsIds = new HashMap();

  ContextData contextData;

  MapSkillsState(this.contextData) {
    contextData.userSkills.forEach((skill) {
      selectedSkillsIds[skill.skillId] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    contextData.allSkills.forEach((skill){
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
      bottomNavigationBar: new BottomNavBar(contextData, 1),
    );
  }

  void save(){
    List<Skill> selectedSkills = [];
    selectedSkillsIds.forEach((key, value) {
      if(value){
        selectedSkills.add(contextData.allSkills.firstWhere((element) => element.skillId == key));
      }
    });

    List<Skill> deletedSkills = [];

    contextData.userSkills.forEach((skill) {
      var skillsService = new SkillsService();
      if(selectedSkills.firstWhere((element) => element.skillId == skill.skillId, orElse: () => null) == null) {
        skillsService.deleteSkill(skill, contextData.user);
        deletedSkills.add(skill);
      }
    });

    contextData.userSkills.removeWhere((skill) => deletedSkills.firstWhere((skillDeleted) => skillDeleted.skillId == skill.skillId, orElse: () => null) != null);

    contextData.userSkills.forEach((oldSkill) {
      selectedSkills.forEach((selectedSkill) {
        if(oldSkill.skillId == selectedSkill.skillId) {
          oldSkill.subSkills.forEach((oldSubSkill) {
            selectedSkill.subSkills.forEach((selectedSubSkill){
              if(oldSubSkill.subSkillId == selectedSubSkill.subSkillId) {
                selectedSubSkill.subSkillRating = oldSubSkill.subSkillRating;
              }
            });
          });
        }
      });
    });

    Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new MapSubSkillsView(selectedSkills, contextData)));
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
    contextData.allSkills.forEach((skill){
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