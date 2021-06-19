import 'package:flutter/material.dart';

class LampSwitchRope extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Color color;
  final bool isSwitchOn;
  final Duration animationDuration;

  const LampSwitchRope({required this.screenWidth,required this.screenHeight,required this.color,required this.isSwitchOn,required this.animationDuration});
      // : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: animationDuration,
      top: screenHeight * 0.4,
      bottom: screenHeight * (isSwitchOn ? 0.18 : 0.22),
      width: 2,
      right: screenWidth * 0.25 - 1,
      child: Container(
        color: color,
      ),
    );
  }
}
