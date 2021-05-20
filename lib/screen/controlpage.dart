import 'package:multidisproject_2/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
class ControlPage extends StatefulWidget {

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool status = false;
  bool status1 = false;
  bool status2 = false;

  bool buzzer1status = false;
  bool light1status = false;
  final databaseReferenceBuzzer = FirebaseFirestore.instance.collection('room1_output').doc('led1');
  final databaseReferenceLight = FirebaseFirestore.instance.collection('room1_output').doc('led2');


  @override
    Widget build(BuildContext context) {
   var buzzer1 =0  ;
    var light1 =0  ;
  return  StreamBuilder(
    stream: FirebaseFirestore.instance.collection("room1_output").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
              AsyncSnapshot snapshot) {  
                 
                if (snapshot.connectionState == ConnectionState.active){
                   print(snapshot.data.docs[0].data()['data']);
                    buzzer1 = snapshot.data.docs[0].data()['data'];
                    light1 = snapshot.data.docs[1].data()['data'];
                    if (buzzer1 ==0){buzzer1status = false;}
                    else{buzzer1status =true;}

                     if (light1 ==0){light1status = false;}
                    else{light1status =true;}
                }
      return new MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: new Scaffold(
            appBar: new AppBar(
              bottom: new TabBar(
                tabs: [
                  Tab(child: Text("Room 1")),
                  Tab(child: Text("Room 2")),
                  Tab(child: Text("Room 3")),
                  Tab(child: Text("Room 4")),
                ],
              ),
              title: Text('Control devices'),
              backgroundColor: Colors.orangeAccent,
            ),
            body: TabBarView(
              children: [
                //ROOM 1
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(50.0),
                  child: Table(
                    //defaultVerticalAlignment: Alignment.center,
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("DEVICES",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("STATUS",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ]),
                      TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Buzzer 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: buzzer1status,
                            onChanged: (bool state) {
                              state
                                  ? databaseReferenceBuzzer
                                      .update({'data': 1})
                                  : databaseReferenceBuzzer
                                      .update({'data': 0}) ;
                              state ? buzzer1status = true :buzzer1status = false;
                    }    ),

                        ),
                      ],
                      ),
                        TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Light 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: light1status,
                            onChanged: (bool state) {
                              state
                                  ? databaseReferenceLight
                                      .update({'data': 1})
                                  : databaseReferenceLight
                                      .update({'data': 0}) ;
                              state ? light1status = true :light1status = false;
                    }    ),

                        ),
                      ],
                      ),

                    ],
                  ),
                ),



                // ROOM  2
                Container(
                    color: Colors.white,
                  padding: EdgeInsets.all(50.0),
                  child: Table(
                    //defaultVerticalAlignment: Alignment.center,
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("DEVICES",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("STATUS",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ]),
                      TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Buzzer 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false, //buzzer1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceBuzzer
                              //         .update({'data': 1})
                              //     : databaseReferenceBuzzer
                              //         .update({'data': 0}) ;
                              // state ? buzzer1status = true :buzzer1status = false;
                    }    ),

                        ),
                      ],
                      ),
                        TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Light 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false,//light1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceLight
                              //         .update({'data': 1})
                              //     : databaseReferenceLight
                              //         .update({'data': 0}) ;
                              // state ? light1status = true :light1status = false;
                    }    ),

                        ),
                      ],
                      ),

                    ],
                  ),


                ), 

                //ROOM 3
                Container(
                          color: Colors.white,
                  padding: EdgeInsets.all(50.0),
                  child: Table(
                    //defaultVerticalAlignment: Alignment.center,
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("DEVICES",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("STATUS",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ]),
                      TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Buzzer 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false, //buzzer1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceBuzzer
                              //         .update({'data': 1})
                              //     : databaseReferenceBuzzer
                              //         .update({'data': 0}) ;
                              // state ? buzzer1status = true :buzzer1status = false;
                    }    ),

                        ),
                      ],
                      ),
                        TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Light 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false,//light1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceLight
                              //         .update({'data': 1})
                              //     : databaseReferenceLight
                              //         .update({'data': 0}) ;
                              // state ? light1status = true :light1status = false;
                    }    ),

                        ),
                      ],
                      ),

                    ],
                  ),


                ),
                // ROOM 4
                Container(
                              color: Colors.white,
                  padding: EdgeInsets.all(50.0),
                  child: Table(
                    //defaultVerticalAlignment: Alignment.center,
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("DEVICES",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                  color: Colors.orangeAccent, // Set border color
                                  width: 3.0),   // Set border width
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)), // Set rounded corner radius
                              boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child: Text("STATUS",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                        ),
                      ]),
                      TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Buzzer 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false, //buzzer1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceBuzzer
                              //         .update({'data': 1})
                              //     : databaseReferenceBuzzer
                              //         .update({'data': 0}) ;
                              // state ? buzzer1status = true :buzzer1status = false;
                    }    ),

                        ),
                      ],
                      ),
                        TableRow(children: [

                        Container (
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text('Light 1',style: TextStyle( fontSize: 23,))
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child:   Switch(
                            value: false,//light1status,
                            onChanged: (bool state) {
                              // state
                              //     ? databaseReferenceLight
                              //         .update({'data': 1})
                              //     : databaseReferenceLight
                              //         .update({'data': 0}) ;
                              // state ? light1status = true :light1status = false;
                    }    ),

                        ),
                      ],
                      ),

                    ],
                  ),

                ),
              ],
            ),
          ),
        ),
      );
        });
    }
}