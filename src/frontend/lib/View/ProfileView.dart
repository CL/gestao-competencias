import 'package:flutter/material.dart';

import '../Model/SkillProfile.dart';
import '../Model/User.dart';
import '../Components/BackgroundProfileAppBar.dart';
import '../Components/CardProfile.dart';
import '../Components/ChipProfile.dart';


class ProfileView extends StatefulWidget {

  final List<SkillProfile> skillsProfile;
  final User user;

  ProfileView(this.skillsProfile, this.user);

  @override
  createState() => new ProfileState(skillsProfile, user);

}

class ProfileState extends State<ProfileView> {

  List<SkillProfile> skillsProfile;
  User user;
  GlobalKey globalKey = new GlobalKey();

  ProfileState(this.skillsProfile, this.user);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double _flexibleSpaceMaxHeight = height*0.4;
    return new Scaffold(
      body: new CustomScrollView(
        slivers: [
         new SliverAppBar(
           title: new Icon(Icons.arrow_back),
           expandedHeight: _flexibleSpaceMaxHeight,
           flexibleSpace: new BackgroundProfileAppBar(animation: kAlwaysDismissedAnimation, image: new Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/RedSquare_SaintBasile_%28pixinn.net%29.jpg/398px-RedSquare_SaintBasile_%28pixinn.net%29.jpg").image),
           bottom: new PreferredSize(
            preferredSize: new Size.fromHeight(_flexibleSpaceMaxHeight*0.67),
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(
                    user.name,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  new Text(
                    user.role,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Divider(),
                  new Text(
                    user.email,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Text(
                    user.phone,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Divider(),
                  new Row(
                    children: getChipList(),
                  )
                ],
              ),
            )
           ) 
        ),
        new SliverList(
          delegate: new SliverChildListDelegate(
            getCardsList()
          ),
        ),
        ],
      )
    );
  }

  List<Widget> getCardsList(){
    List<Widget> skillsCards = [];

    skillsProfile.forEach((skill){
      skillsCards.add(new CardProfile(skill));
    });

    return skillsCards;
  }

  List<Widget> getChipList(){
    List<Widget> chips = [];

    user.skillsSummary.forEach((skill){
      chips.add(new ChipProfile(skill));
    });

    return chips;
  }
}