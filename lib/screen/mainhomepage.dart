import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


header(context) {
  return Container(
    width: double.infinity,
    height: 300,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      // color: Colors.cyan,
      color:Theme.of(context).primaryColor,
      // color: Colors.amber,
      //  color: Colors.pink,
    ),
    padding: EdgeInsets.only(
      left: 30,
      top: 50,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset("assets/idea.png", width: 75,height:75), 
        SizedBox(height: 10.0),
        Text('MY IDEAL',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text('LIBRARY',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              // color: Colors.cyan ,
              color: Colors.yellow ,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}


class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var lightRoom1 =''  ;
  var lightRoom2 ='99'  ;
  var lightRoom3 ='99 ' ;
  var lightRoom4 ='99 ' ;

  var noiseRoom1 =''  ;
  var noiseRoom2 ='100'  ;
  var noiseRoom3 ='100'  ;
  var noiseRoom4 ='100'  ;

rowRoom(context, room) {
  var lightRoom = '';
  var noiseRoom = '';
  var link = '';
  switch(room) { 
      case 1: { 
        lightRoom = lightRoom1;
        noiseRoom = noiseRoom1;
        link = "assets/monitor_1.png";
       } 
      break; 
      case 2: { 
        lightRoom = lightRoom2;
        noiseRoom = noiseRoom2;
        link = "assets/read.png";
       } 
      break; 
      case 3: { 
        lightRoom = lightRoom3;
        noiseRoom = noiseRoom3;
        link = "assets/conversation.png";
       } 
      break; 
      case 4: { 
        lightRoom = lightRoom4;
        noiseRoom = noiseRoom4;
        link = "assets/listening.png";
       } 
      break;   
   } 

  return Container(
    width: double.infinity,
    height: 138,
    decoration: new BoxDecoration(
      color: Colors.grey.shade100.withOpacity(1),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(20.0),  
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5.0,    // soften the shadow
          spreadRadius: 2.0,  //extend the shadow
          offset: Offset(
            5,                // Move to right 10  horizontally
            5.0,                 // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    margin: EdgeInsets.only(
      top:  8 ,
      left: 25,
      right: 25,
    ),

    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[ 
       Row (
          children: <Widget>[

            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset(link, width: 75,height:75), 
                    SizedBox(height: 5.0),
                    Text('ROOM ${room}',  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15.0,),),  
                  ],
                ),
              ),
            ),
            
            Container(height: 80, child: VerticalDivider(color: Colors.grey), margin: const EdgeInsets.only( right: 10.0),),

            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Light  ', textAlign: TextAlign.center,style: TextStyle(color:Colors.grey)),
                    SizedBox(height: 10.0),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset("assets/lights.png", width: 40,height: 40,),
                           SizedBox(width: 5.0),
                          Text('${lightRoom}',style: TextStyle(fontSize: 25)), 
                        ],
                      ),
                  ],
                ),
              ),

            ),
            SizedBox(width: 20.0),

            Expanded(
              child: Container(
                margin:  EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Noise ', textAlign: TextAlign.center,style: TextStyle(color:Colors.grey)),
                    SizedBox(height: 10.0),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset("assets/noise.png", width: 40,height: 40,), 
                        SizedBox(width: 3.0),
                        Text('${noiseRoom}',style: TextStyle(fontSize: 25)),
                      ],
                    ),
        
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ],
    ),
  );
}

  
  
_rowRoom (context){
return Container(
  margin: EdgeInsets.only(
      top:  220 ,
    ),
    child: Column(
      children: <Widget>[ 
       rowRoom(context, 1),
       rowRoom(context, 2),
       rowRoom(context, 3),
       rowRoom(context, 4),
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
      ]
    )
);
}

  
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
                    body: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        header(context),
                        _rowRoom(context)
                      
                      ],
                    ),
                    )
                  );
              });
        }
}
  
 
