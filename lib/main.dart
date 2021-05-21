// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/homepage.dart';
import 'package:multidisproject_2/screen/loginpage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors
        fontFamily: 'Poppins',

      ),
      home: LandingPage(),

    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if( snapshot.hasError) {
            return Scaffold(
              body: Center (
                child: Text("Error: ${snapshot.error}"),
              )
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    User? user = snapshot.data as User?;
                    if(user == null) {
                      return LoginPage();
                    }
                  }
                  return Homepage();
                },
            );
          }
          return Scaffold(
          body: Center (
          child: Text("Checking Authentication../")
          )
          );
        },
    );
  }
}

