import 'package:flutter/material.dart';

class _BackgroundLayer {
  _BackgroundLayer({ double parallax })
    : parallaxTween = new Tween<double>(begin: 0.0, end: parallax);
  final Tween<double> parallaxTween;
}

class BackgroundProfileAppBar extends StatelessWidget {

  const BackgroundProfileAppBar({ this.animation, this.image });

  final ImageProvider image;

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double _flexibleSpaceMaxHeight = height*0.4;

    final List<_BackgroundLayer> _kBackgroundLayers = <_BackgroundLayer>[
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight),
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight),
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight / 2.0),
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight / 4.0),
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight / 2.0),
      new _BackgroundLayer(parallax: _flexibleSpaceMaxHeight)
    ];

    return new AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return new Stack(
          children: _kBackgroundLayers.map((_BackgroundLayer layer) {
            return new Positioned(
              top: -layer.parallaxTween.evaluate(animation),
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: new Container(
               decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  image: this.image,
                )
              ),
             )
            );
          }).toList()
        );
      }
    );
  }
}