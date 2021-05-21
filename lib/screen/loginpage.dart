// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/mainhomepage.dart';
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password ="";
  bool loginfail = false;
  bool createfail = false;

  Future <void> _createUser() async {
    try {
      print("Email $_email");
      UserCredential userCredential = await FirebaseAuth
          .instance
      .createUserWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      setState((){
        createfail = true;
      });
    }
    catch(e) {print("Error: $e");
      setState((){
        createfail = true;
      });}

    }

  Future <void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      setState((){
        loginfail = true;
      });
    }
    catch(e) {print("Error: $e");
      setState((){
        loginfail = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text ("Login"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center (
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: InputDecoration (
                  hintText: "Your Email",
                  errorText: createfail ? 'Email address is adready in use':null,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                obscureText: true,
                decoration: InputDecoration (
                  hintText: "Your Password",
                  errorText: loginfail ? 'Wrong password':null,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    color: Colors.orangeAccent,
                    minWidth: MediaQuery. of(context). size. width*0.4,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
                    onPressed: _login,
                    child: Text("Login", style: TextStyle(color: Colors.white,),
                    ),
                  ),

                  FlatButton(
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
                    onPressed: _createUser,
                    child: Text("Create new account", style: TextStyle(color: Colors.white),),
                  ),
                ],
              )
            ]
          ),
        )
      ),
    );
  }
}