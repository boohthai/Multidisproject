import 'package:multidisproject_2/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multidisproject_2/screen/living_home/living_home_page.dart';

class ElectronicsListModels {
  int id;
  String name;
  String image;
  bool status;

  ElectronicsListModels({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
  });
}

List<ElectronicsListModels> electronicsList_1 = [
    ElectronicsListModels(
      id: 1,
      name: 'LED 1',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 2,
      name: 'LED 2',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 3,
      name: 'BUZZER 1',
      image: 'assets/bell_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 4,
      name: 'BUZZER 2',
      image: 'assets/bell_on.png',
      status: false,
    ),
];
List<ElectronicsListModels>  electronicsList_2 = [
    ElectronicsListModels(
      id: 1,
      name: 'LED 1',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 2,
      name: 'LED 2',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 3,
      name: 'BUZZER 1',
      image: 'assets/bell_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 4,
      name: 'BUZZER 2',
      image: 'assets/bell_on.png',
      status: false,
    ),
];
List<ElectronicsListModels>  electronicsList_3 = [
    ElectronicsListModels(
      id: 1,
      name: 'LED 1',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 2,
      name: 'LED 2',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 3,
      name: 'BUZZER 1',
      image: 'assets/bell_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 4,
      name: 'BUZZER 2',
      image: 'assets/bell_on.png',
      status: false,
    ),
];
List<ElectronicsListModels>  electronicsList_4= [
    ElectronicsListModels(
      id: 1,
      name: 'LED 1',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 2,
      name: 'LED 2',
      image: 'assets/lamp_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 3,
      name: 'BUZZER 1',
      image: 'assets/bell_on.png',
      status: false,
    ),
    ElectronicsListModels(
      id: 4,
      name: 'BUZZER 2',
      image: 'assets/bell_on.png',
      status: false,
    ),
];

class ControlPage extends StatefulWidget {
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {



  @override
  Widget build(BuildContext context) {
  return  StreamBuilder(
    stream: FirebaseFirestore.instance.collection("room1_output").snapshots(includeMetadataChanges: true),
    builder: (BuildContext context,
          AsyncSnapshot snapshot) {    
            if (snapshot.connectionState == ConnectionState.active){
        
                electronicsList_1[0].status = snapshot.data.docs[0].data()['data'] == 0 ?  false :true;
                electronicsList_1[2].status = snapshot.data.docs[1].data()['data'] == 0 ?false :true;

                electronicsList_2[0].status = snapshot.data.docs[2].data()['data'] == 0 ?  false :true;
                electronicsList_3[0].status = snapshot.data.docs[3].data()['data'] == 0 ?  false :true;
                electronicsList_4[0].status = snapshot.data.docs[4].data()['data'] == 0 ?  false :true;

                electronicsList_1[1].status = snapshot.data.docs[5].data()['data'] == 0 ?  false :true;
                electronicsList_2[1].status = snapshot.data.docs[6].data()['data'] == 0 ?  false :true;
                electronicsList_3[1].status = snapshot.data.docs[7].data()['data'] == 0 ?  false :true;
                electronicsList_4[1].status = snapshot.data.docs[8].data()['data'] == 0 ?  false :true;                   
                
            }
            print(Theme.of(context).primaryColor);

      return new MaterialApp(

        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child:  Scaffold(
            appBar:  AppBar(
              // backgroundColor: Colors.white,
               backgroundColor: Theme.of(context).primaryColor,

              flexibleSpace: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              new TabBar(
                 //Change background color from here
                
                indicatorColor: Colors.orangeAccent,
                //  indicatorColor: Theme.of(context).primaryColor,

                indicatorWeight:7,
                labelColor: Colors.black,
                // unselectedLabelColor: Colors.yellow,
                tabs: [
                  // new Tab(child: Text('Room 1')),
                  // new Tab(child: Text('Room 2')),//icon: new Icon(Icons.directions_transit)
                  // new Tab(child: Text('Room 3')),
                  // new Tab(child: Text('Room 4')),
                  // new Tab(child: Text('All leds')),

                  new Tab(child:  Column(children:[ Image.asset("assets/monitor_1.png", width: 25,height:25),Text('Room 1')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/read.png", width: 25,height:25),Text('Room 2')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/conversation.png", width: 25,height:25),Text('Room 3')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/listening.png", width: 25,height:25),Text('Room 4')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/idea.png", width: 25,height:25),Text('All leds')])),

     
                    
                ],
              ),
            ],
          ),
            ),
            body: TabBarView(
           
              children: [
                Stack(
                  children: <Widget>[
                      header(1),
                      deviceBox(context,1)
                  ]       
                ),
                 Stack(
                  children: <Widget>[
                      header(2),
                      deviceBox(context,2)
                  ]       
                ),
                 Stack(
                  children: <Widget>[
                      header(3),
                      deviceBox(context,3)
                  ]       
                ),
                 Stack(
                  children: <Widget>[
                      header(4),
                      deviceBox(context,4)
                  ]       
                ),
                LivingHomePage(),
            
              ],
            ),
          ),
        ),
      );
    });
    }
}

deviceBox(context, room) {
    var electronicsList;
    switch(room) { 
      case 1: electronicsList = electronicsList_1;break; 
      case 2: electronicsList = electronicsList_2;break; 
      case 3: electronicsList = electronicsList_3;break; 
      case 4: electronicsList = electronicsList_4;break; 
   } 

    return Container(
     child: Padding(
          padding: EdgeInsets.only(left: 20, top: 60, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:150),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 2,
                  itemCount: electronicsList.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (_context, index) {
                      var nameDoc;
                      switch(index) { 
                        case 0: { 
                           switch(room) { 
                              case 1: nameDoc = 'light_relay_control';break; 
                              case 2: nameDoc = 'u1_room2';break; 
                              case 3: nameDoc = 'u1_room3';break; 
                              case 4: nameDoc = 'u1_room4';break; 
                          } 
                        } 
                            break; 
                        case 1: { 
                           switch(room) { 
                              case 1: nameDoc = 'u2_room1';break; 
                              case 2: nameDoc = 'u2_room2';break; 
                              case 3: nameDoc = 'u2_room3';break; 
                              case 4: nameDoc = 'u2_room4';break; 
                          } 
                        } 
                            break; 
                        case 2: { 
                          switch(room) { 
                              case 1: nameDoc = 'sound_buzzer';break; 
                              case 2: nameDoc = 'u_sound';break; 
                              case 3: nameDoc = 'u_sound';break; 
                              case 4: nameDoc = 'u_sound';break; 
                          }    
                        } 
                          break; 
                        case 3: { 
                           nameDoc = 'u_sound';
                        } 
                          break; 
                      
                  } 
                  
                  return Container(
                    padding: EdgeInsets.only(top:20, left:20),
                    // height: index.isEven ? 200 : 240,
                    height: index.isEven ? 200 : 200,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                             offset: Offset(0, 0), color: Color(0xfff1f0f2))
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: 
                        electronicsList[index].status
                            // ? [Color(0xff669df4), Color(0xff4e80f3)]

                            ? [Theme.of(context).primaryColor.withOpacity(0.3),Theme.of(context).primaryColor.withOpacity(0.3)]
                            : [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          electronicsList[index].name,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF0D1333),
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                        Text(
                          electronicsList[index].status ?'Turn on' :'Turn off',
                          style: TextStyle(
                            color: Color(0xFF0D1333).withOpacity(.5),
                          ),
                          
                        ),

                        SizedBox(height:15),
              
                        Image.asset(electronicsList[index].image, width: 65,height: 65,), 

                        Row(
                          children:[
                            SizedBox(width:80),
                            Switch(
                                value: electronicsList[index].status,
                                activeColor: Theme.of(context).primaryColor,
                                // activeColor: Colors.blue,
                                onChanged: (bool state) {
                                  state
                                      ?  FirebaseFirestore.instance.collection('room1_output').doc(nameDoc)
                                          .update({'data': index < 2 ? 1: 100})
                                      :  FirebaseFirestore.instance.collection('room1_output').doc(nameDoc)
                                          .update({'data': 0}) ;
                                  state ? electronicsList[index].status = true : electronicsList[index].status = false;
                                }    
                              ),
                          ]
                        )
                      ],
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ), 
  );
}

header(room) {
  return Container(
    width: double.infinity,
    height: 250,//300,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      color: Colors.cyan,
      image: DecorationImage(
        image:
            AssetImage( "assets/bk${room}.jpeg"),
        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.0), BlendMode.luminosity),
        fit: BoxFit.cover,
      ),
    ),
    padding: EdgeInsets.only(
      left: 30,
      top: 30,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset("assets/idea.png", width: 75,height:75), 
        SizedBox(height: 10.0),
        Text('Room ${room}',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Stack(
        children: [
          Text(
            'DEVICES',
            style: TextStyle(
              fontSize: 40,
                 fontWeight: FontWeight.w900,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = Colors.black,
              
            ),
          
          ),
          Text(
            'DEVICES',
            style: TextStyle(
              fontSize: 40,
              color: Colors.yellow.shade600,
               fontWeight: FontWeight.w900,
            ),
          ),
        ]
      ),
      ],
    ),
  );
}








