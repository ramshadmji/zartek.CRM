import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/home_widget.dart';
import 'package:zartek/login.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 2), () {
     checkUser();
});
     
    
      }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                           
                            Padding(
                              padding: EdgeInsets.only(top: 120.0),
                            ),
                            Text(
                              "Zartek",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 64.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                        
                
                       
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }
    
      void checkUser() async {
        FirebaseAuth firebaseAuth=FirebaseAuth.instance;
        FirebaseUser firebaseUser= await firebaseAuth.currentUser();

        if(firebaseUser == null)
        {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          //signed out
        }
        else{
          //signed in
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        }
 
      }
}
