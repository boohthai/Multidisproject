import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingPage extends StatefulWidget {


  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool status = false;
  double _currentLightValue =0;
  double _currentsoundValue = 0;

    final databaseReferenceBuzzer = FirebaseFirestore.instance.collection('room1_input').doc('noise_threshold');
    final databaseReferenceLight = FirebaseFirestore.instance.collection('room1_input').doc('light_threshold');
  double sound = 1.1; 
  double light = 1.1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseFirestore.instance.collection("room1_input").snapshots(includeMetadataChanges: true),
      builder:(BuildContext context,
              AsyncSnapshot snapshot){
                
                 if (snapshot.connectionState == ConnectionState.active){
                   print(snapshot.data.docs[2].data()['data']);
                    sound = double.parse(snapshot.data.docs[2].data()['data']);
                    light = double.parse(snapshot.data.docs[0].data()['data']);
                }
                
                if (sound != _currentsoundValue){
                  _currentsoundValue = sound;
                }
                if (light != _currentLightValue){
                  _currentLightValue = light;
                }
                
    return Scaffold(
      appBar: AppBar(title: Text('Setting'),
          backgroundColor: Colors.orangeAccent,),
      body:

          Column (
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: [
              Row(
                children:<Widget> [
                  Expanded(
                    child: Text ("  Automatic Control", textAlign: TextAlign.center,
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
                        height: 35.0,
                        valueFontSize: 10.0,
                        toggleSize: 15.0,
                        value: status,
                        borderRadius: 30.0,
                        padding: 8.0,
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
              ),
              
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text("Set light thresholds", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              ),
              ),

              Slider(
                value: _currentLightValue,
                min: 0,
                max: 250,
                divisions:10,
                label: _currentLightValue.round().toString(),
                onChanged: (double value) {
                setState(() {
                databaseReferenceLight.update({'data': value.round().toString()});
                _currentLightValue = value;
                });
              },
              ),

              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text("Set sound thresholds", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                ),
              ),

              Slider(
                value: _currentsoundValue,
                min: 0,
                max: 250,
                divisions: 10,
                label: _currentsoundValue.round().toString(),
                onChanged: (double value) {
                  databaseReferenceBuzzer.update({'data': value.round().toString()});
                    _currentsoundValue = value;
             
                },
              ),
            ],
          )
    );
    }
    );
  }
}
