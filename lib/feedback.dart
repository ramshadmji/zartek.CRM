import 'package:flutter/material.dart';

import 'cardview.dart';


class Feedbackk extends StatefulWidget {
  @override
  _Feedback createState() => new _Feedback();
}

class _Feedback extends State<Feedbackk> {
  @override
  Widget build(BuildContext context) {
    
 
    
    return Scaffold(
     appBar: AppBar(
       title: Text('Feedback',
        style: const TextStyle(
    color:  const Color(0xfffffafa),
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontStyle:  FontStyle.normal,
    fontSize: 20.0
  )),
     ),
   
   
        body:CardV(page: ProjectPages.feedback
                    ), );
    
  }

  
}

