import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/living_home/living_home_page.dart';

class LampSwitch extends StatelessWidget {
  final Function() onTap;
  final bool isSwitchOn;
  final Color toggleOnColor, toggleOffColor, color;
  final screenWidth, screenHeight;
  final Duration animationDuration;

  const LampSwitch({
    
    required this.onTap,
    required this.isSwitchOn,
    this.screenWidth,
    this.screenHeight,
    required this.animationDuration,
    required this.toggleOnColor,
    required this.toggleOffColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
   
    return Positioned(
      //bottom: screenHeight * 0.31,
      bottom: screenHeight * 0.15,
      width: 30,
      left: screenWidth * 0.75 - 15,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: animationDuration,
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: isSwitchOn ? toggleOnColor : toggleOffColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              left: 0,
              right: 0,
              top: isSwitchOn ? 42 : 4,
              
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
