import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class MainHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainHomePage> {
  bool relay1pressed = false;
  final databaseReferenceTest = FirebaseFirestore.instance.collection('noise_feed').doc('qMBoZX6uRcUfkN3eebhi');

@override
  Widget build(BuildContext context) {
    var data =''  ;
  return  StreamBuilder(
    stream: FirebaseFirestore.instance.collection("noise_feed").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
              AsyncSnapshot snapshot) {  
                 
                if (snapshot.connectionState == ConnectionState.active){
                   print(snapshot.data.docs[0].data()['value']);
                    data = snapshot.data.docs[0].data()['value'];
                }
          return Container(
            child:Row(
            children:[
                Text("${data}"),
            LiteRollingSwitch(
                  value: relay1pressed,
                  textOn: 'active',
                  textOff: 'inactive',
                  colorOn: Colors.deepOrange,
                  colorOff: Colors.blueGrey,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onChanged: (bool state) {
                    state
                        ? databaseReferenceTest
                            .update({'value': '1'})
                        : databaseReferenceTest
                            .update({'value': '0'}) ;
                    }    )
              ]
            )
          );
    }
  );
}}