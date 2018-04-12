import 'package:flutter/material.dart';

import 'BackgroundProfileAppBar.dart';
import 'CardProfile.dart';
import 'ChipProfile.dart';
import 'Profile.dart';

class ProfileState extends State<Profile> {

  GlobalKey globalKey = new GlobalKey();

  void teste(){

  }

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
                    "Mariana Azzi",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  new Text(
                    "UI/UX Designer | Sênior",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Divider(),
                  new Text(
                    "mariana.azzi@dtidigital.com.br",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Text(
                    "31 00000-0000",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  new Divider(),
                  new Row(
                    children: [
                      new ChipProfile("UX"),
                      new ChipProfile("UI"),
                      new ChipProfile("Strategist"),
                      new ChipProfile("Experience"),
                    ],
                  )
                ],
              ),
            )
           ) 
        ),
        new SliverList(
          delegate: new SliverChildListDelegate(
            [
              new CardProfile(),
            ],
          ),
        ),
        ],
      )
    );
  }
}