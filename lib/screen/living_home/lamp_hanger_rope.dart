import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LampHangerRope extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Color color;

  const LampHangerRope({ required this.screenWidth, required this.screenHeight, required this.color}) ;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: screenWidth * 0.362,
      width: 45,
      top: 0,
      child: Stack(
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(shape: BoxShape.circle,color: color),

          ),
          Center(
            child: Container(
              color: color,
              margin: EdgeInsets.only(top: 10),
              width: 15,
              height: screenHeight * 0.18,
            ),
          ),
        ],
      ),
    );
  }
}
