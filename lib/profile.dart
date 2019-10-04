import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


void main() => runApp(new ProfilePage());

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      debugShowCheckedModeBanner: false,

      home: new Profile(),

    );
  }
}





class Profile extends StatefulWidget {



  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Profile> {


  @override
  Widget build(BuildContext context) {


    return new Scaffold(

        backgroundColor: Color(0xFFFFFFFF),
        body: new Stack(

          children: <Widget>[
            ClipPath(
              child: Container(

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: [const Color(0xFF0277BD), const Color(0xFF00E5FF)], // whitish to gray
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),


              ),
              clipper: GetClipper(),
            ),

            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 4.5  ,
                child: Column(
                  children: <Widget>[

//          Padding(
//            padding: const EdgeInsets.only(left:40.0),
                    ClipOval(

                        child: Center(child:
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: CircleAvatar(
                            backgroundImage: ExactAssetImage('images/pro5.png'),
                            minRadius:60,
                            maxRadius:60,

                          ),
                        ), )

                    ),
//          ),




//
//                Padding(
//                  padding: const EdgeInsets.only(right:50.0),
//
////                  child: SizedBox(height: 20.0),
//                ),
                    Padding(
                      padding: const EdgeInsets.only(top:25.0,left: 35.0),
                      child: FutureBuilder(
                          future: FirebaseAuth.instance.currentUser(),
                          builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                            if(snapshot.hasData){


                              return Padding(
                                padding: const EdgeInsets.only(left:15.0),
                                child: Text( snapshot.data.email
                                  ,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times new Roman'),
                                ),
                              );
                            }

                            else {
                              return Text( 'Loading...'
                                ,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times new Roman'),
                              );
                            }
                          }
                      ),
                    ),


// SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,left: 45.0),
                      child: FlatButton.icon(
                        color: Colors.white,
                        icon: Icon(Icons.exit_to_app,color:  const Color(0xff4886ff)), //`Icon` to display
                        label: Text("Logout",style: TextStyle(
                            color: Colors.blueAccent, fontSize: 14.0,fontFamily: 'Times new Roman')),
                        onPressed: () {
                          _signout();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                        },
                      ),
                    ),





//  SizedBox(height: 15.0),
                    Column(

                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,

                          child: Container(
                            margin: new EdgeInsets.symmetric(horizontal: 35.0),
                            child: new Text(
                                "Contact us:",
                                style: const TextStyle(
                                    fontWeight:FontWeight.bold ,
                                    color:  const Color(0xff4d78e9),
                                    fontFamily: "TimesNewRomanPS-MT",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )),
                          ),
                        ),
                      ],
                    ),



//
//                 SizedBox( height: 170,
//                 width:250,

//        child:
                    Padding(
                      padding: const EdgeInsets.only(top:15.0,left: 50),
                      child: Column(

                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left:40.0,top: 5.0),
                            child: GestureDetector(
                              onTap: ()
                              {
                                UrlLauncher.launch("tel:(+91) 7736226886");
                              },
                              child: ListTile(
//                  contentPadding: EdgeInsets.symmetric(horizontal: 35.0),
                                title:
                                Text(

                                  "(+91) 7736226886",


                                  style: const TextStyle(
                                    color:  const Color(0xff4886ff),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "TimesNewRomanPSMT",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14.0,

                                  ),


                                ),

                                leading: Icon(
                                  Icons.call,

                                  color:  const Color(0xff4886ff),
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:40.0,top:5.0),
                            child: GestureDetector(
                              onTap: ()
                              {
                                UrlLauncher.launch("mailto:info@zartek.in");
                              },
                              child: ListTile(
//                  contentPadding: EdgeInsets.symmetric(horizontal: 35.0),
                                title: new Text(
                                    "info@zartek.in",
                                    style: const TextStyle(
                                        color:  const Color(0xff4886ff),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "TimesNewRomanPSMT",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    )),
                                leading: Icon(
                                  Icons.mail,
                                  color:  const Color(0xff4886ff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

//        ),

                  ],
                ))
          ],
        ));

  }

  void _signout() async{
    await FirebaseAuth.instance.signOut();
  }


}


class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 140, 1.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {

    return false;
  }
}
