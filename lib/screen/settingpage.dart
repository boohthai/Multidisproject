import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:multidisproject_2/screen/theme_values.dart';
import 'package:multidisproject_2/screen/theme_notifier.dart';
import 'package:multidisproject_2/screen/theme_values.dart';
import 'package:multidisproject_2/screen/theme_button.dart';

class SettingPage extends StatefulWidget {

 SettingPage();
  @override
  _SettingPageState createState() => _SettingPageState();
}
 ThemeData _customTheme = ThemeData(
      primaryColor: 
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
     
      backgroundColor: Colors.white);
class _SettingPageState extends State<SettingPage> {
 
  bool status = false;

  double _currentsoundValue = 0;
  RangeValues  _currentRangeValues =RangeValues (40,80);

  final databaseReferenceLightMin = FirebaseFirestore.instance.collection('room1_input').doc('light_threshold_min');
  final databaseReferenceLightMax = FirebaseFirestore.instance.collection('room1_input').doc('light_threshold_max');
  final databaseReferenceBuzzer = FirebaseFirestore.instance.collection('room1_input').doc('noise_threshold');

  double sound = 1.0; 
  double lightMin = 1.0;
  double lightMax = 2.0;
Widget _themeColorContainer(String colorName, Color color) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 16),
      color: color,
      child: Text(colorName,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.button),
    );
  }
  themeChange(){
return     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                   Column(
                     children:[
                        IconButton(
                      
                      icon: const Icon(Icons.favorite, size:40),
                      color: _customTheme.primaryColor,
                          onPressed: () => _openDialog("Primary Color",
                                  _customTheme.primaryColor, true),
                    ),
                     SizedBox(height:10),
                     ]
                   ),
                    SizedBox(width:70),
                    ThemeButton(buttonThemeData: _customTheme),
                
              ],
            );
}

   void _openDialog(String title, Color currentColor, bool primaryColor) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: Container(
            height: 220,
            child: MaterialColorPicker(
              selectedColor: currentColor,
              onColorChange: (color) => setState(() => _customTheme =
                  (primaryColor)
                      ? _customTheme.copyWith(primaryColor: color)
                      : _customTheme.copyWith(accentColor: color)),
              onMainColorChange: (color) => setState(() => _customTheme =
                  (primaryColor)
                      ? _customTheme.copyWith(primaryColor: color)
                      : _customTheme.copyWith(accentColor: color)),
            ),
          ),
   
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseFirestore.instance.collection("room1_input").snapshots(includeMetadataChanges: true),
      builder:(BuildContext context,
              AsyncSnapshot snapshot){
                
                if (snapshot.connectionState == ConnectionState.active){
                    lightMin = double.parse(snapshot.data.docs[1].data()['data']);
                    lightMax = double.parse(snapshot.data.docs[0].data()['data']);
                    sound = double.parse(snapshot.data.docs[3].data()['data']);
                }
  
                if (sound != _currentsoundValue){
                  _currentsoundValue = sound;
                }
           
                if (lightMin != _currentRangeValues.start || lightMax != _currentRangeValues.end){
                  _currentRangeValues = RangeValues(lightMin,lightMax);
                }
    buttonAuto(){
      return  Row(
                children:<Widget> [
                  Expanded(
                    child: Text (" Automatic Control", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  SizedBox( width: 50, height: 30,),
                  Expanded (
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: FlutterSwitch(
                        width: 80.0,
                        height: 40.0,
                        valueFontSize: 10.0,
                        toggleSize: 25.0,
                        value: status,
                        borderRadius: 30.0,
                        padding: 8.0,
                        activeColor: Colors.amber,
                        // activeTextColor: Colors.black,
                      
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ),
                  ),

                ],
              );
    }      
    lightSlider(){
      return Column(children:[
         Container(
                alignment: Alignment.topLeft,
                 padding: const EdgeInsets.only(left:25.0, bottom:20),
                child:
                 Row(children: [
                    Text("Light threshold", style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,) ),
                    SizedBox(width:100),
                    Text(" ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}", style: TextStyle(fontSize: 17,color: Colors.grey.shade600) ),
                    SizedBox(width:10),
                    Image.asset('assets/lights.png', width: 25,height: 25,),    
                  ],)
              ),

              SliderTheme(
              data: SliderThemeData(
                trackHeight: 5,
                thumbColor: Color(0xfffc1767),
              ),
              child: 
                RangeSlider(
                  values: _currentRangeValues,
                  activeColor: Color(0xfffc1767).withOpacity(0.6),
                  inactiveColor: Color(0xfff04a29).withOpacity(0.2), 
                  min: 0,
                  max: 1000,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      databaseReferenceLightMin.update({'data': values.start.round().toString()});
                      databaseReferenceLightMax.update({'data': values.end.round().toString()});
                      _currentRangeValues = values;
                    });
                  },
                ),
            ),

               
      ]);
    }
    noiseSlider(){
      return Column(children: [
         Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left:25.0, bottom:20),
            child: Row(children: [
              Text("Sound threshold", style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,) ),
               SizedBox(width:130),
              Text(" ${_currentsoundValue.toInt()}", style: TextStyle(fontSize: 17,color: Colors.grey.shade600) ),
              SizedBox(width:10),
              Image.asset('assets/noise.png', width: 25,height: 25,),    
            ],)
          ),
              
          SliderTheme(
              data: SliderThemeData(
                trackHeight: 5,
                trackShape: GradientRectSliderTrackShape(gradient: LinearGradient(
              colors: <Color> [
                const Color(0xff18f2eb).withOpacity(0.3),
                const Color(0xff472be3).withOpacity(0.8),
                // const Color(0xfff04a29).withOpacity(0.6),
                // const Color(0xfffc1767).withOpacity(0.6),
              ]
              ),
              darkenInactive: true),
              // thumbColor: Colors.deepPurple,
              thumbColor: const Color(0xff472be3).withOpacity(0.8),
              ),
              child: 
                Slider(
                    value: _currentsoundValue,
                    min: 0,
                    max: 1000,
                    divisions: 1001,
                    label: _currentsoundValue.round().toString(),
                    onChanged: (double value) {
                      databaseReferenceBuzzer.update({'data': value.round().toString()});
                        _currentsoundValue = value;
                
                    },
                  ),
            ),
        
           
      ]);
    }
    themeBox(){
      return Column(children: [
         Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left:25.0, bottom:20),
            child:  Text("Theme setting", style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,) )
          ),
              
       themeChange(),
           
      ]);
    }
    header1() {
  return Container(
    margin: EdgeInsets.only(
      left:10,
      right:10,
      top:30,
      bottom: 10

    ),
    width: double.infinity,
    height: 650,//560,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color: Colors.black, width: 2),
       borderRadius: BorderRadius.circular(20),
      // color: Colors.black,
       color: Colors.white,
      

      
    ),
    padding: EdgeInsets.only(
      left: 0,
      top: 50,
    ),
   child: Column (
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(children: [
                 SizedBox(width:30),
                Text(
              'Settings',
              style: TextStyle(
                fontSize: 40,
                // color: Colors.white,
                color: Colors.black,
                  fontWeight: FontWeight.w900,
              ),
            ),
      
              ],),
              
              SizedBox(height:15),
              buttonAuto(),
              Container(height: 20, child: Divider(color: Colors.grey), margin: const EdgeInsets.only( left: 15.0,right: 15.0),),

              lightSlider(),
              Container(height: 40, child: Divider(color: Colors.grey), margin: const EdgeInsets.only( left: 15.0,right: 15.0),),

              noiseSlider(),
              Container(height: 30, child: Divider(color: Colors.grey), margin: const EdgeInsets.only( left: 15.0,right: 15.0),),

       themeBox(),

 
            ],
          ),
  );
}

    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
      body:
          Stack(children: <Widget>[
            // header(context),
            header1(),

            
          ],)
    );
    }
    );
  }
}



class GradientRectSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {

  final LinearGradient gradient;
  final bool darkenInactive;
  const GradientRectSliderTrackShape({ this.gradient: const LinearGradient(colors: [Colors.lightBlue, Colors.blue]), this.darkenInactive: true});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final ColorTween activeTrackColorTween = ColorTween(begin: sliderTheme.disabledActiveTrackColor, end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
      ? ColorTween(begin: sliderTheme.disabledInactiveTrackColor, end: sliderTheme.inactiveTrackColor) 
      : activeTrackColorTween;
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr) ? trackRect.top - (additionalActiveTrackHeight / 2): trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr) ? trackRect.bottom + (additionalActiveTrackHeight / 2) : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr) ? activeTrackRadius : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr) ? activeTrackRadius: trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl) ? trackRect.top - (additionalActiveTrackHeight / 2) : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl) ? trackRect.bottom + (additionalActiveTrackHeight / 2) : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl) ? activeTrackRadius : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl) ? activeTrackRadius : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}