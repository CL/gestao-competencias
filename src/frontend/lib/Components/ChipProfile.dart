import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class ChipProfile extends StatelessWidget {
  final String text;

  ChipProfile(this.text);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      padding: new EdgeInsets.all(4.0),
      child: new Chip(
        backgroundColor: Colors.transparent,
        label: new Container(
          color: Colors.transparent,
          padding: new EdgeInsets.only(left: 2.0, right: 2.0),
          child: new Text(
            this.text,
            style: new TextStyle(
              color: Colors.grey,
            ),
          ),
        )
      ),
    );
  }
}