import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Model/Skill.dart';
import '../Model/ContextData.dart';





class FilterView extends StatefulWidget{
  final ContextData contextData;

  FilterView(this.contextData);

  @override
  createState() => new FilterState(contextData);
}

class FilterState extends State<FilterView>{
  ContextData contextData;
  Skill selectedSkill;
  SubSkill selectedSubSkill;

  FilterState(this.contextData);

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return MaterialApp(
      title: 'Filter View',
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
                  padding: new EdgeInsets.only(right: width*0.7),
                  child: new Text(
                    'SKILLS',
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 1.0),
                      fontSize: height*0.028,
                    ),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(12.0),
                  width: width*0.9,
                  child: new DropdownButton<Skill>(
                    onChanged: (item) {
                      setState(() {
                        selectedSkill = item;
                        selectedSubSkill = null;
                      });
                    },
                    value: selectedSkill,
                    items: getSkillsList(),
                    hint: new Row(

                      children: <Widget>[
                        new Icon(Icons.bookmark_border, color: new Color(0xffbebebe)),
                        new Container(
                          padding: new EdgeInsets.fromLTRB(width*0.1, 0.0, width*0.41, 0.0),
                          child: new Text('Escolher', textScaleFactor: 1.5),
                        ),
                      ],
                    ),
                    iconSize: width*0.08,
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(right: width*0.7),
                  child: new Text(
                    'DOMÍNIO',
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      color: new Color.fromRGBO(45, 182, 195, 1.0),
                      fontSize: height*0.028,
                    ),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.all(12.0),
                  width: width*0.9,
                  child: new DropdownButton<SubSkill>(
                    onChanged: (item) {
                      setState(() => selectedSubSkill = item);
                    },
                    value: selectedSubSkill,
                    items: selectedSkill!=null?getSubSkillsList(selectedSkill.subSkills):[],
                    hint: new Row(
                      children: <Widget>[
                        new Icon(Icons.timeline, color: new Color(0xffbebebe)),
                        new Container(
                          padding: new EdgeInsets.fromLTRB(width*0.1, 0.0, width*0.41, 0.0),
                          child: new Text('Escolher', textScaleFactor: 1.5),
                        ),
                      ],
                    ),
                    iconSize: width*0.08,
                  ),
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: new Container(
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
                    child: new Text('APLICAR'),
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
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
