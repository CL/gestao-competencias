import 'dart:collection';

import 'package:flutter/material.dart';

import '../Model/ContextData.dart';
import '../Service/SkillsService.dart';
import '../Model/Skill.dart';
import 'MapSubSkillsView.dart';


class MapSkillsView extends StatefulWidget {
  final ContextData contextData;
  
  MapSkillsView(this.contextData);

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
        backgroundColor: Colors.cyan,
        actions: [
          new IconButton(
            onPressed: save,
            icon: new Icon(Icons.save)
          )
        ],
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
        selectedSkills.add(contextData.allSkills.firstWhere((element) => element.skillId == key));
      }
    });

    var skillsService = new SkillsService();

    List<Skill> toBeRemovedSkills = [];

    contextData.userSkills.forEach((skill) {
      if(selectedSkills.firstWhere((element) => element.skillId == skill.skillId, orElse: () => null) == null) {
        skillsService.deleteSkill(skill, contextData.user);
        toBeRemovedSkills.add(skill);
      }
    });
    
    toBeRemovedSkills.forEach((removedSkill) {
      contextData.userSkills.removeWhere((userSkill) => userSkill.skillId == removedSkill.skillId);
    });

    contextData.userSkills.forEach((oldSkill) {
      selectedSkills.forEach((selectedSkill) {
        if(oldSkill.skillId == selectedSkill.skillId) {
          oldSkill.subSkills.forEach((oldSubSkill) {
            selectedSkill.subSkills.forEach((selectedSubSkill){
              if(oldSubSkill.subSkillId == selectedSubSkill.subSkillId) {
                selectedSubSkill.subSkillRating = oldSubSkill.subSkillRating;
                selectedSubSkill.subSkillInterest = oldSubSkill.subSkillInterest;
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
    double width = MediaQuery.of(context).size.width;

    List<Widget> newWidgets = [];
    newWidgets.add(new Container(
      padding: EdgeInsets.only(left: width*0.009),
      child: new Text(
        "Selecione as habilidades que você tem domínio de acordo com as skills listadas.",
        style: new TextStyle(
          color: new Color.fromRGBO(97, 97, 97, 1.0),
          fontSize: 14.0
        ),
    )));
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
                        activeColor: Colors.cyan,
                        onChanged: (value){
                          setState((){
                            selectedSkillsIds[skill.skillId] = value;
                          });
                        },
                      )
                    ],
                  ),
                  new Container(
                    child: new Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 6.0,
                      runSpacing: 4.0,
                      children: getChipsSubSkills(skill.subSkills)
                    ),
                  ),
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
