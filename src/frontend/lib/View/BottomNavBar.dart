import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/View/SearchView.dart';
import '../Model/Skill.dart';
import '../Model/User.dart';
import '../View/ProfileView.dart';

class BottomNavBar extends StatelessWidget{
  int index = 0;

  BottomNavBar(user,skills){
      this.user = user;
      this.skills = skills;
  }
  User user;
  List<Skill> skills;

  @override
  Widget build(BuildContext context) {
      return new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.assessment,
              color: Colors.grey,
              size: 24.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.search,
              color: Colors.grey,
              size: 24.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.add_circle,
              color: Color(0xff2db6c3),
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.favorite_border,
              color: Colors.grey,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
        ],
        onTap: (int i){
          switch(i){
            case 0:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView()));
                break;
              }
            case 1:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView()));
                break;
              }
            case 2:
              {

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