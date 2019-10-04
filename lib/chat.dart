

import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';



class  Chat extends StatefulWidget {


  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  initState() {
    super.initState();
    whatsAppOpen();
  }


    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home:

          Scaffold(

            appBar: AppBar(
                title: Text('Feedback'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),


          ));


    }
  }

void whatsAppOpen() async {
  await FlutterLaunch.launchWathsApp(phone: "917736226886", message: "Hello");


}