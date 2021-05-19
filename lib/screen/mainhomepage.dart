import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:percent_indicator/percent_indicator.dart';
class MainHomePage extends StatefulWidget {

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Colors.orangeAccent,
        title: Text ("Homepage"),
      ),
      body: Center (
        // child: MaterialButton (
        //   onPressed: ()  async {
        //     await FirebaseAuth.instance.signOut();
        //   },
        //   child: Text("Sign out"),
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
                    child: CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 8.0,
                    percent: 0.8,
                    center: new Icon(
                      Icons.lightbulb,
                      size: 50.0,
                      color: Colors.amber,
                    ),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.green,
                  ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.5,
                      center: new Icon(
                        Icons.volume_up,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
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
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.8,
                      center: new Icon(
                        Icons.lightbulb,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.5,
                      center: new Icon(
                        Icons.volume_up,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
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
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.8,
                      center: new Icon(
                        Icons.lightbulb,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.6,
                      center: new Icon(
                        Icons.volume_up,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
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
                          Text('ROOM 4'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.8,
                      center: new Icon(
                        Icons.lightbulb,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: 0.6,
                      center: new Icon(
                        Icons.volume_up,
                        size: 50.0,
                        color: Colors.amber,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
