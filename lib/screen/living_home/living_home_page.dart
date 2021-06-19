import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/living_home/lamp_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LEDBulb.dart';
import 'lamp.dart';
import 'lamp_hanger_rope.dart';
import 'lamp_switch_rope.dart';
import 'room_name.dart';

import 'package:provider/provider.dart';
import 'package:multidisproject_2/screen/theme_values.dart';
import 'package:multidisproject_2/screen/theme_notifier.dart';

final darkGray = const Color(0xFF232323);
// final bulbOnColor = const Color(0xFFFFE12C);
// final bulbOffColor = const Color(0xFFC1C1C1);
final switchColor  = const Color(0xFFFC1EA0);
final bulbOnColor = const Color(0xFFFFE12C);
final bulbOffColor = const Color(0xFFC1C1C1);

final animationDuration = const Duration(milliseconds: 500);

final databaseReferenceBuzzer = FirebaseFirestore.instance.collection('room1_output').doc('sound_buzzer');
final databaseReferenceLight = FirebaseFirestore.instance.collection('room1_output').doc('light_relay_control');
final databaseReferenceLight2_r1 = FirebaseFirestore.instance.collection('room1_output').doc('u2_room1');
final databaseReferenceLight1_r2 = FirebaseFirestore.instance.collection('room1_output').doc('u1_room2');
final databaseReferenceLight2_r2 = FirebaseFirestore.instance.collection('room1_output').doc('u2_room2');
final databaseReferenceLight1_r3 = FirebaseFirestore.instance.collection('room1_output').doc('u1_room3');
final databaseReferenceLight2_r3 = FirebaseFirestore.instance.collection('room1_output').doc('u2_room3');
final databaseReferenceLight1_r4 = FirebaseFirestore.instance.collection('room1_output').doc('u1_room4');
final databaseReferenceLight2_r4 = FirebaseFirestore.instance.collection('room1_output').doc('u2_room4');

class LivingHomePage extends StatefulWidget {

  @override
  _LivingHomePageState createState() => _LivingHomePageState();
}
var _isSwitchOn = false;
class _LivingHomePageState extends State<LivingHomePage> {
  

@override
Widget build(BuildContext _context) {

  final screenWidth = MediaQuery.of(context).size.width ;
  final screenHeight = MediaQuery.of(context).size.height ;
  


alo(){
  return Stack(
          children: <Widget>[
          LampHangerRope(screenWidth: screenWidth, screenHeight: screenHeight, color: darkGray),
          LEDBulb(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            onColor: bulbOnColor,
            offColor: bulbOffColor,
            isSwitchOn: _isSwitchOn,
          ),
          Lamp(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            gradientColor: bulbOnColor,
            animationDuration: animationDuration,
          ),
          LampSwitch(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            // toggleOnColor: Provider.of<ThemeNotifier>(context).getTheme().primaryColor,
            toggleOnColor: Color(0xffe91e63).withOpacity(0.8),

            toggleOffColor: bulbOffColor,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            onTap: () {
                
              setState(() {
                _isSwitchOn = !_isSwitchOn;
              });
              _isSwitchOn ?  databaseReferenceLight.update({'data': 1}):  databaseReferenceLight.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight2_r1.update({'data': 1}):  databaseReferenceLight2_r1.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight1_r2.update({'data': 1}):  databaseReferenceLight1_r2.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight2_r2.update({'data': 1}):  databaseReferenceLight2_r2.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight1_r3.update({'data': 1}):  databaseReferenceLight1_r3.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight2_r3.update({'data': 1}):  databaseReferenceLight2_r3.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight1_r4.update({'data': 1}):  databaseReferenceLight1_r4.update({'data': 0}) ;
              _isSwitchOn ?  databaseReferenceLight2_r4.update({'data': 1}):  databaseReferenceLight2_r4.update({'data': 0}) ;


            },
            animationDuration: animationDuration,
          ),
          LampSwitchRope(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            animationDuration: animationDuration,
          ),
 
        ],
      );
}


    return Scaffold(
      body: Container(
        
      child: Stack(
        children:<Widget>[
            mainAlbumImage(context),
            alo(),

        ]
      )
      )
    );
  }
}
mainAlbumImage(context) {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      ),
      // color: Colors.cyan,
      color:Provider.of<ThemeNotifier>(context).getTheme().primaryColor.withOpacity(0.5)
    ),
    padding: EdgeInsets.only(
      left: 30,
      top: 30,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
         SizedBox(width: 245.0),
          Column(
            children:<Widget>[
             
              Row(
                children:<Widget>[
                   SizedBox(width: 50.0),
                    Image.asset("assets/idea.png", width: 50,height:50), 
                ]
              ),
              Text('Switch',
            style: TextStyle(
              color: Colors.black ,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
         
            ),
              Text('All Led',
            style: TextStyle(
              color: Colors.yellow ,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
            ),
        
            ),
            
            ]
          )
          
      ],
    ),
  );
}