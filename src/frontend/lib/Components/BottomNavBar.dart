import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Service/SkillsService.dart';
import '../View/MapSkillsView.dart';
import '../View/SearchView.dart';
import '../Model/Skill.dart';
import '../Model/User.dart';
import '../View/ProfileView.dart';

class BottomNavBar extends StatefulWidget{

  User user;
  List<Skill> skills;
  int index;

  BottomNavBar(user,skills,index){
    this.user = user;
    this.skills = skills;
    this.index = index;
  }
  @override
  State<StatefulWidget> createState() => new BottomNavBarState(user,skills,this.index);
}

class BottomNavBarState extends State<BottomNavBar>{
  int index;

  BottomNavBarState(user,skills,index){
      this.user = user;
      this.skills = skills;
      this.index = index;
  }
  User user;
  List<Skill> skills;

  @override
  Widget build(BuildContext context) {
      return new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.index,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.assessment,
              color: index == 0 ? Color(0xff5e529d) : Colors.grey,
              size: 24.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.search,
              color: index == 1 ? Color(0xff5e529d) : Colors.grey,
              size: 24.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.add_circle,
              color: Color(0xff2db6c3),
              size: 34.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.favorite_border,
              color: index == 3 ? Color(0xff5e529d) : Colors.grey,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.person_outline,
              color: index == 4 ? Color(0xff5e529d) : Colors.grey,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
        ],
        onTap: (int i){
          setState(() {
            this.index = i;
          });
          switch(i){
            case 0:
              {

                break;
              }
            case 1:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView(this.user,this.skills)));
                break;
              }
            case 2:
              {
                new SkillsService().getAllSkills(user).then((allSkills) {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MapSkillsView(allSkills, user, skills)));
                });
                break;
              }
            case 3:
              {

                break;
              }
            case 4:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ProfileView(skills, user)));
                break;
              }
            default:
              {
                break;
              }
          }
        },
      );
  }

}