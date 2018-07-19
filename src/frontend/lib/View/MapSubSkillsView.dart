import 'package:flutter/material.dart';

import '../Components/StarRating.dart';
import '../Model/Skill.dart';
import '../Model/User.dart';
import 'ProfileView.dart';


class MapSubSkillsView extends StatefulWidget {
  final List<Skill> skills;
  final User user;
  
  MapSubSkillsView(this.skills, this.user, {Key key}) : super(key: key);

  @override
  createState() => new MapSubSkillsState(skills, user);
}

class MapSubSkillsState extends State<MapSubSkillsView> {
  List<Skill> skills;
  User user;

  MapSubSkillsState(this.skills, this.user);

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
        child: new Scrollbar(
          child: new CustomScrollView(
            slivers: [new SliverList(
              delegate: new SliverChildListDelegate(
                getSubSkillsList()
              ),
            )]
          )
          
        ),
      )
      
    );
  }

  void save(){
    Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ProfileView(skills, user)));
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
        new Card(
          child: new Column(
            children: [
              new Container(
                padding: new EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                child: new Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      skill.skillName,
                      style: new TextStyle(
                        color: new Color.fromRGBO(45, 182, 195, 100.0),
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    new Row(
                      children: [
                        new Text(
                          skill.totalSubSkills.toString(),
                          style: new TextStyle(
                            color: new Color.fromRGBO(97, 97, 97, 100.0),
                            fontSize: 14.0,
                          ),
                        ),
                        new Text(
                          " skills",
                          style: new TextStyle(
                            color: new Color.fromRGBO(190, 190, 190, 100.0),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              new Container(
                child: new Divider(height: 15.0,color: Colors.grey[300])
              ),
              new Container(
                child: new Column(
                  children: listSubSkills(skill),
                )
              )
              
            ],
          ), 
        )
      );
      
    });

    return newWidgets;
  }

  List<Widget> listSubSkills(Skill skill){
    List<Widget> subSkills = [];

    skill.subSkills.forEach((sub) {
      subSkills.add(
        new Container(
          padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
          child: new Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    sub.subSkillName,
                    style: new TextStyle(
                      color: new Color.fromRGBO(97, 97, 97, 100.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              new Container(
                 padding: new EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new StarRating(
                      rating: sub.subSkillRating, 
                      color: new Color.fromRGBO(245, 184, 43, 100.0),
                      onRatingChanged: (rating) { changeRating(rating, skill, sub); },
                    ),
                    new GestureDetector(
                      child: new Icon(
                        sub.subSkillInterest ? Icons.favorite : Icons.favorite_border, 
                        color: sub.subSkillInterest ? Colors.red : Colors.grey,
                      ),
                      onTap: () { favoritarSubSkill(skill, sub); },
                    ) 
                  ]
                ),
              )
              
            ]
          )
        )
      );
      subSkills.add(
        new Container(
          padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
          child: new Divider(height: 15.0,color: Colors.grey[300])
        ),
      );
    });
    return subSkills;
  }

  void changeRating(double rating, Skill skill, SubSkill sub) {
    int indexSkill = skills.indexOf(skill);
    int indexSubskill = skill.subSkills.indexOf(sub);
    List<Skill> skillsTemp = skills;
    skillsTemp[indexSkill].subSkills[indexSubskill].subSkillRating = rating;
    setState(() { skills = skillsTemp; });
  }

  void favoritarSubSkill(Skill skill, SubSkill sub) {
    int indexSkill = skills.indexOf(skill);
    int indexSubskill = skill.subSkills.indexOf(sub);
    List<Skill> skillsTemp = skills;
    skillsTemp[indexSkill].subSkills[indexSubskill].subSkillInterest = !skillsTemp[indexSkill].subSkills[indexSubskill].subSkillInterest;
    setState(() { skills = skillsTemp; });
  }
}