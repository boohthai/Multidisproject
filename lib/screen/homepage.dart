import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/mainhomepage.dart';
import 'package:multidisproject_2/screen/controlpage.dart';
import 'package:multidisproject_2/screen/settingpage.dart';
import 'package:multidisproject_2/screen/reportpage.dart';
class Homepage extends StatefulWidget {
  //const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 50, fontWeight: FontWeight.bold);
  int selectedPage = 0;

  final _pageOptions = [
    MainHomePage(),
    ControlPage(),
    ReportPage(),
    SettingPage(),
    
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar:
        BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, ),//color: Colors.black,),
              label: "Home",
              backgroundColor:Colors.orangeAccent // Theme.of(context).primaryColor//Colors.orangeAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.toggle_on),
              label: 'Control',
              backgroundColor: Colors.orangeAccent,
            ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              label: 'Report',
              backgroundColor: Colors.orangeAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              backgroundColor: Colors.orangeAccent,
            ),
          ],

          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
        
    );

  }
}
