import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/ContextData.dart';
import '../View/MapSkillsView.dart';
import '../View/SearchView.dart';
import '../View/ProfileView.dart';

class BottomNavBar extends StatefulWidget{

  final ContextData contextData;
  final int index;

  BottomNavBar(this.contextData, this.index);

  @override
  State<StatefulWidget> createState() => new BottomNavBarState(contextData, index);
}

class BottomNavBarState extends State<BottomNavBar>{
  int index;
  ContextData contextData;

  BottomNavBarState(this.contextData, this.index);

  @override
  Widget build(BuildContext context) {
      return new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.index,
        items: <BottomNavigationBarItem>[
          /*
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.assessment,
              color: index == 0 ? Color(0xff5e529d) : Colors.grey,
              size: 24.0,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          */
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.search,
              color: index == 0 ? Color(0xff5e529d) : Colors.grey,
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
          /*
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.favorite_border,
              color: index == 3 ? Color(0xff5e529d) : Colors.grey,
            ),
            title: new Text("", style: new TextStyle(fontSize: 1.0),),
          ),
          */
          new BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: new Icon(
              Icons.person_outline,
              color: index == 2 ? Color(0xff5e529d) : Colors.grey,
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView(contextData)));
                break;
              }
            case 1:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MapSkillsView(contextData)));
                break;
              }
            case 2:
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ProfileView(contextData.userSkills, contextData.user, contextData)));
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