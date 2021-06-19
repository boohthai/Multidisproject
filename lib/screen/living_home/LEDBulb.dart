import 'package:flutter/material.dart' ;
class LEDBulb extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Color onColor, offColor;
  final bool isSwitchOn;
  final Duration animationDuration = const Duration(milliseconds: 1500);

  const LEDBulb(
      {required this.screenWidth,required this.screenHeight, required this.onColor,required this.offColor,required this.isSwitchOn, })
      ;

  @override
  Widget build(BuildContext context) {

    return Positioned(
      left: screenWidth * 0.3,
      top: screenHeight * 0.35,
      child: AnimatedContainer(
        duration: animationDuration,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSwitchOn ? onColor : offColor,
        ),
      ),
    );
  }
}
