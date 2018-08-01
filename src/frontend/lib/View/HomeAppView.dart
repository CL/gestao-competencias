import 'package:flutter/material.dart';

import '../Model/ContextData.dart';
import '../View/MapSkillsView.dart';
import '../View/ProfileView.dart';
import '../View/SearchView.dart';

class HomeAppView extends StatelessWidget {

  ContextData contextData;

  HomeAppView(this.contextData);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 2,
        length: 3,
        child: Scaffold(
          bottomNavigationBar: new TabBar(
              tabs: [
                new Tab(icon: new Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
                new Tab(icon: new Icon(
                  Icons.add_circle,
                  color: Color(0xff2db6c3),
                )),
                new Tab(icon: new Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                )),
              ],
          ),
          body: TabBarView(
            children: [
              new SearchView(contextData),
              new MapSkillsView(contextData),
              new ProfileView(contextData.userSkills, contextData.user, contextData),
            ],
          ),
        ),
      ),
    );
  }
}