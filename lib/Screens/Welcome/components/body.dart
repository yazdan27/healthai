import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height and width of screen
    return Background(child: Column(children: <Widget>[],),);
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    this.child,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets\images\cheems.png",
                width: size.width * 0.3,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets\images\cheems.png",
                width: size.width * 0.2,
              )),
          child,
        ],
      ),
    );
  }
}

