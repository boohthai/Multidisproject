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
  var noiseRoom1 =''  ;
  var noiseRoom2 =10  ;
  var noiseRoom3 =10  ;

   var lightRoom1 =''  ;
  var lightRoom2 =10  ;
  var lightRoom3 =10  ;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("room1_input").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
              AsyncSnapshot snapshot){
                 if (snapshot.connectionState == ConnectionState.active){
                    noiseRoom1 = snapshot.data.docs[3].data()['data'];
                    lightRoom1 = snapshot.data.docs[1].data()['data'];
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
                        //ROW 1
                        Container(
                          margin: EdgeInsets.only(right:10, left:10, top:10),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:  Row (
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
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${lightRoom1}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Noise Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom1}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),
                          ),
                          ],
                        )
                    ),
                    //ROW 2
                         Container(
                          margin: EdgeInsets.only(right:10, left:10, top:10),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:  Row (
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
                                  Text('ROOM 2'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom2}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Noise Intensity', textAlign: TextAlign.center),
                                  Text('${lightRoom2}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),
                          ),
                          
                          ],
                        )
                    ),
                            //ROW 2
                         Container(
                          margin: EdgeInsets.only(right:10, left:10, top:10),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:  Row (
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
                                  Text('ROOM 3'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom3}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: <Widget>[
                                  Text('Noise Intensity', textAlign: TextAlign.center),
                                  Text('${lightRoom3}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),
                          ),
                          
                          ],
                        )
                    ),
                    
                      
                      ],
                    )
                ),
    );



              });
  }
}