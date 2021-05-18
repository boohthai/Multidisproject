import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
class MainHomePage extends StatefulWidget {

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var dataNoise =''  ;
  // @override
  // final rowRoom = 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("noise_feed").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
              AsyncSnapshot snapshot){
                 if (snapshot.connectionState == ConnectionState.active){
                   print(snapshot.data.docs[0].data()['value']);
                    dataNoise = snapshot.data.docs[0].data()['value'];
                }
              return Scaffold(
                appBar: AppBar (
                  backgroundColor: Colors.orangeAccent,
                  title: Text ("Homepage"),
                ),
                body: Center ( 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Row (
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.computer,
                            color: Colors.green,
                            size: 80.0,
                          ),
                          Text('ROOM 1'),
                         
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          // Icon(
                          //   Icons.pie_chart,
                          //   color: Colors.green,
                          //   size: 80.0,
                          // ),
                           Text('${dataNoise}',style: TextStyle(fontSize: 25)),
                          Text('Light Intensity', textAlign: TextAlign.center),
                        ],
                      ),
                    ),

                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          // Icon(
                          //   Icons.pie_chart,
                          //   color: Colors.green,
                          //   size: 80.0,
                          // ),
                          Text('${dataNoise}',style: TextStyle(fontSize: 25)),
                          Text('Noise', textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                      ],
                    )
                ),
    );



              });
  }
}


