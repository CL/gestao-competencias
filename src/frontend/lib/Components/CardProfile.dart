import 'package:flutter/material.dart';

import '../Model/Skill.dart';
import 'StarRating.dart';

class CardProfile extends StatefulWidget{
  final Skill skillProfile;

  CardProfile(this.skillProfile);

  @override
  createState() => new CardProfileState(skillProfile);

}

class CardProfileState extends State<CardProfile> {
  bool expanded = false;
  Skill skillProfile;

  CardProfileState(this.skillProfile);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        setState(() { expanded = !expanded; });
      },
      child: new Card(
        child: new Column(
          children: [
            new Container(
              padding: new EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: new Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    skillProfile.skillName,
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 100.0),
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  new Row(
                    children: [
                      new Text(
                        getRatedSkills().toString() + "/" + skillProfile.totalSubSkills.toString(),
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
              padding: new EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: new Row(
                children: [
                  new Container(
                    padding: new EdgeInsets.only(right: 8.0),
                    child: new Text(
                      skillProfile.skillRating.toStringAsFixed(1),
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        color: new Color.fromRGBO(97, 97, 97, 100.0)
                      ),
                    ),
                  ),
                  new StarRating(rating: skillProfile.skillRating, color: new Color.fromRGBO(245, 184, 43, 100.0))
                ],
              ),
            ),
            new Container(
              child: expanded ? new Column(
                      children: listSubSkills(),
                    ) : new Container(height: 0.0, width: 0.0),
            )
            
          ],
        ), 
      )
    );
  }

  int getRatedSkills() {
    return skillProfile.subSkills.where((subskill) => subskill.subSkillRating != 0.0).length;
  }

  List<Widget> listSubSkills(){
    List<Widget> subSkills = [];

    skillProfile.subSkills.forEach((sub) {
      if(sub.subSkillRating != 0.0) {
        subSkills.add(
            new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              new Row(
                children: [
                  new Container(
                    padding: new EdgeInsets.only(right: 6.0),
                    child: new Icon(
                      sub.subSkillInterest ? Icons.favorite : Icons.favorite_border,
                      color: sub.subSkillInterest ? Colors.red : Colors.grey,
                    ),
                  ),
                  new Text(
                    sub.subSkillName,
                    style: new TextStyle(
                      color: new Color.fromRGBO(97, 97, 97, 100.0),
                      fontSize: 14.0
                    ),
                  ),
                ],
                  ),
                  new StarRating(rating: sub.subSkillRating,
                      color: new Color.fromRGBO(245, 184, 43, 100.0))
                ],
              ),
            )
        );
        subSkills.add(
          new Container(
              padding: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
              child: new Divider(height: 15.0, color: Colors.grey[300])
          ),
        );
      }
    });

    return subSkills;
  }

}