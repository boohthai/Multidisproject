import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multidisproject_2/screen/mainhomepage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI',
      home: MyHomePage(),
     
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email = "";
  String _password ="";
  bool loginfail = false;
  bool createfail = false;

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
loginSection(context, isLogin,function) {
  return Container(
    width: double.infinity,
    height: 315,
    decoration: new BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5.0,    // soften the shadow
          spreadRadius: 0.0,  //extend the shadow
          offset: Offset(
            0,                // Move to right 10  horizontally
            10.0,             // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    margin: EdgeInsets.only(
      top: 340,
      left: 25,
      right: 25,
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Text(isLogin? 'Welcome Bach Khoa Library!':'Create new account!',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ),
        
        SizedBox(height: 5.0),
        TextField(
          onChanged: (value) {
            _email = value;
          },
          decoration: InputDecoration(labelText: 'Email',errorText: createfail ? 'Email address is adready in use':null),
        ),
        SizedBox(height: 5.0),
        TextField(
          onChanged: (value) {
            _password = value;
          },
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password', focusColor: Colors.blue, 
          errorText: loginfail ? 'Wrong password':null,
          
                  ),
        ),
        SizedBox(height: 25.0),
        RaisedGradientButton(
          child: Text(
            isLogin? 'Sign In': 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          gradient: LinearGradient(
            colors:isLogin ? <Color>[Colors.blueAccent,Colors.cyan, Colors.yellow] : <Color>[Colors.cyan, Colors.yellow] ,
          ),
          onPressed: function
          // (){
          //   print('button clicked');
          // }
        ),
        SizedBox(height: 15.0),
        
       Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Text(isLogin?'Don\'t have an Account?  ':'Already have an Account?  ',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ),
     
        GestureDetector(
        
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  isLogin?  MySignupPage():  MyHomePage()),
          );
        },
          child: Text(
            isLogin? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        

        
          ],
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          mainAlbumImage(true),
          loginSection(context, true, _login ),
         
        ],
      ),
)
    );
  }
}


class MySignupPage extends StatefulWidget {
 
  @override
  _MySignupPageState createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
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
      });
      }

    }
  loginSection(context, isLogin,function) {
  return Container(
    width: double.infinity,
    height: 315,
    decoration: new BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5.0,    // soften the shadow
          spreadRadius: 0.0,  //extend the shadow
          offset: Offset(
            0,                // Move to right 10  horizontally
            10.0,             // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    margin: EdgeInsets.only(
      top: 340,
      left: 25,
      right: 25,
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Text(isLogin? 'Welcome Bach Khoa Library!':'Create new account!',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ),
        
        SizedBox(height: 5.0),
        TextField(
          onChanged: (value) {
            _email = value;
          },
          decoration: InputDecoration(labelText: 'Email',errorText: createfail ? 'Email address is adready in use':null),
        ),
        SizedBox(height: 5.0),
        TextField(
          onChanged: (value) {
            _password = value;
          },
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password', focusColor: Colors.blue, 
          errorText: loginfail ? 'Wrong password':null,
          
                  ),
        ),
        SizedBox(height: 25.0),
        RaisedGradientButton(
          child: Text(
            isLogin? 'Sign In': 'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          gradient: LinearGradient(

            colors:isLogin ? <Color>[Colors.blueAccent,Colors.cyan, Colors.yellow] : <Color>[Colors.cyan, Colors.yellow] ,
          ),
          onPressed: function
          // (){
          //   print('button clicked');
          // }
        ),
        SizedBox(height: 15.0),
        
       Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Text(isLogin?'Don\'t have an Account?  ':'Already have an Account?  ',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ),
     
        GestureDetector(
        
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  isLogin?  MySignupPage():  MyHomePage()),
          );
        },
          child: Text(
            isLogin? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        

        
          ],
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          mainAlbumImage(false),
          loginSection(context, false,_createUser),
         
        ],
      ),
)
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function() onPressed;

  const RaisedGradientButton({
    Key? key ,
    required this.child,
    required this.gradient ,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  }) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
      borderRadius: new BorderRadius.circular(10.0),
      gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

mainAlbumImage(isLogin) {
  return Container(
    width: double.infinity,
    height: 500,
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      image: DecorationImage(
        image:
            AssetImage(isLogin ? "assets/bk5.png" : "assets/bk1.jpeg"),
        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.0), BlendMode.luminosity),
        fit: BoxFit.cover,
      ),
    ),
    padding: EdgeInsets.only(
      left: 30,
      top: 130,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset("assets/idea.png", width:75, height:75), 
        SizedBox(height: 10.0),
        Text('MY IDEAL',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text('LIBRARY',
        style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: isLogin ? Colors.yellow : Colors.limeAccent[700],
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}


