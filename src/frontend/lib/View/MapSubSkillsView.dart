import 'package:flutter/material.dart';
import '../Components/BottomNavBar.dart';
import '../View/LoginView.dart';

import '../Service/SkillsService.dart';
import '../Components/StarRating.dart';
import '../Model/Skill.dart';
import '../Model/User.dart';
import 'ProfileView.dart';


class MapSubSkillsView extends StatefulWidget {
  final List<Skill> allSkills;
  final List<Skill> oldSkills;
  final User user;
  
  MapSubSkillsView(this.allSkills, this.user, this.oldSkills, {Key key}) : super(key: key);

  @override
  createState() => new MapSubSkillsState(allSkills, user, oldSkills);
}

class MapSubSkillsState extends State<MapSubSkillsView> {
  List<Skill> selectedSkills;
  List<Skill> oldSkills;
  User user;
  bool loading;

  MapSubSkillsState(this.selectedSkills, this.user, this.oldSkills, [this.loading=false]);

  final snackBarError = new SnackBar(
      content: new Text('Erro ao salvar. Tente novamente mais tarde.'),
      duration: new Duration(seconds: 3)
  );

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
      ),
      bottomNavigationBar: new BottomNavBar(this.user, selectedSkills, 2),
    );
  }

  void save(){
    setState(() { loading = true;} );

    List<SubSkill> subskillsToUpdate = [];
    List<SubSkill> subskillsToSave = [];


    selectedSkills.forEach((selectedSkill) {
      oldSkills.forEach((oldSkill) {
        if(selectedSkill.skillId == oldSkill.skillId) {
          selectedSkill.subSkills.forEach((selectedSubskill) {
             oldSkill.subSkills.forEach((oldSubskill) {
               if(oldSubskill.subSkillRating != selectedSubskill.subSkillRating || oldSubskill.subSkillInterest != selectedSubskill.subSkillInterest) {
                 selectedSubskill.entryId = oldSubskill.entryId;
                 subskillsToUpdate.add(selectedSubskill);             
               }
             });
          });
        }
      });
    });

    selectedSkills.forEach((selectedSkill) {
      selectedSkill.subSkills.forEach((subSkill) {
        if(subskillsToUpdate.firstWhere((updateSubskill) => updateSubskill.subSkillId == subSkill.subSkillId) == null) {
          subskillsToSave.add(subSkill);
        }
      });
    });

    var skillService = new SkillsService();

    skillService.updateSubskills(subskillsToUpdate, user);

    skillService.saveSkills(subskillsToSave, user).then((success) {
      if(success) {
        new SkillsService().getUserSkills(user).then((skills) {
          setState(() { loading = false;} );
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ProfileView(skills, user)));
        });
        
      } else {
          Scaffold.of(context).showSnackBar(snackBarError);
      }
      
    });
    
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
        )
      ],
    ));

    selectedSkills.forEach((skill){
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

    newWidgets.add(
      loading ? new Container(
          child: new Center(
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: new Color(0xccffffff),
            ),
          ),
        ): new Container()
    );
    newWidgets.add(
      loading ? new LoadingCircleRotate(): new Container()
    );

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
    int indexSkill = selectedSkills.indexOf(skill);
    int indexSubskill = skill.subSkills.indexOf(sub);
    List<Skill> skillsTemp = selectedSkills;
    skillsTemp[indexSkill].subSkills[indexSubskill].subSkillRating = rating;
    setState(() { selectedSkills = skillsTemp; });
  }

  void favoritarSubSkill(Skill skill, SubSkill sub) {
    int indexSkill = selectedSkills.indexOf(skill);
    int indexSubskill = skill.subSkills.indexOf(sub);
    List<Skill> skillsTemp = selectedSkills;
    skillsTemp[indexSkill].subSkills[indexSubskill].subSkillInterest = !skillsTemp[indexSkill].subSkills[indexSubskill].subSkillInterest;
    setState(() { selectedSkills = skillsTemp; });
  }
}