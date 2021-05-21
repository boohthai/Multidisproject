import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
class MainHomePage extends StatefulWidget {

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  var lightRoom1 =''  ;
  var lightRoom2 =10  ;
  var lightRoom3 =10  ;

  var noiseRoom1 =''  ;
  var noiseRoom2 =10  ;
  var noiseRoom3 =10  ;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("room1_input").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
              AsyncSnapshot snapshot){
                 if (snapshot.connectionState == ConnectionState.active){
                    lightRoom1 = snapshot.data.docs[2].data()['data'];
                    noiseRoom1 = snapshot.data.docs[4].data()['data'];
                }
              return Scaffold(
                appBar: AppBar (
                  backgroundColor: Colors.orangeAccent,
                  title: Text ("Homepage"),
                ),
                body: SingleChildScrollView(
                  child:Center ( 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //ROW 1
                        Container(
                          margin: EdgeInsets.only(right:10, left:10, top:15),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(20),
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
                                    color: Colors.pink,
                                    size: 75.0,
                                  ),
                                  Text('ROOM 1'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${lightRoom1}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          margin: EdgeInsets.only(right:10, left:10, top:15),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.cyan[50],
                            borderRadius: BorderRadius.circular(20),
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
                                    color: Colors.cyan,
                                    size: 75.0,
                                  ),
                                  Text('ROOM 2'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom2}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            //ROW 3
                         Container(
                          margin: EdgeInsets.only(right:10, left:10, top:15),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(20),
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
                                    size: 75.0,
                                  ),
                                  Text('ROOM 3'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom3}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    //ROW 4
                         Container(
                          margin: EdgeInsets.only(right:10, left:10, top:15, ),
                          height: 100,//double.infinity,
                          width: 450,//double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(20),
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
                                    color: Colors.orange,
                                    size: 75.0,
                                  ),
                                  Text('ROOM 3'),
                                
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  
                                  Text('Light Intensity', textAlign: TextAlign.center),
                                  Text('${noiseRoom3}',style: TextStyle(fontSize: 25)),
                                  
                                ],
                              ),
                            ),

                          ),
                          Expanded(
                            child: Container(
                              margin:  EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
               
                    Container(
                height: 60,
                child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container (
                  child:FlatButton (
                    color: Colors.orangeAccent,
                    minWidth: MediaQuery. of(context).size.width*0.25,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
                    onPressed: ()  async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: Text("Sign out", style: TextStyle (fontSize: 20, color: Colors.white),),
                  ),
                ),

              ),
              ),
              
                      
                      ],
                    )
                ),
                )
              );



              });
    // );
  }
}