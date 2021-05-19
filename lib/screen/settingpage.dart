import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:flutter_switch/flutter_switch.dart';
class SettingPage extends StatefulWidget {


  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool status = false;
  double _currentSliderValue = 120;
  double _currentsoundValue = 0;
  @override
  Widget build(BuildContext context) {
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
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text ("Automatic Control",
                      style: TextStyle(fontSize: 20,),
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
                child: Text("Set light thresholds", style: TextStyle(fontSize: 20,),
              ),
              ),
              Slider(
                value: _currentSliderValue,
                min: 100,
                max: 150,
                divisions: 5,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                setState(() {
                _currentSliderValue = value;
                });
              },
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text("Set sound thresholds", style: TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: _currentsoundValue,
                min: 0,
                max: 120,
                divisions: 5,
                label: _currentsoundValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentsoundValue = value;
                  });
                },
              ),
            ],
          )
    );
  }
}
