import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class ChipProfile extends StatelessWidget {
  final String text;

  ChipProfile(this.text);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(4.0),
      child: new Chip(
        border: new StadiumBorder(
          side: new BorderSide(
            color: Colors.white,
            width: 1.5
          )
        ),
        backgroundColor: Colors.transparent,
        label: new Padding(
          padding: new EdgeInsets.only(left: 2.0, right: 2.0),
          child: new Text(
            this.text,
            style: new TextStyle(
              color: Colors.white
            ),
          ),
        )
      ),
    );
  }
}