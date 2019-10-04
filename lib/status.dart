import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'invoice_pdf.dart';



void main() {
  runApp(new MaterialApp(
    // Title
      title: "Project Status",
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
final  String docID,userId;

 MyHome({this.docID,this.userId});

  @override
  MyHomeState createState() => new MyHomeState();
}

int progress = 0;

class MyHomeState extends State<MyHome> {

     @override
  void initState() {
   
    super.initState();
    print(widget.userId);
    print(widget.docID);
    getdata();
  }
   List<Step> my_steps_status;

  void getdata() async{

    QuerySnapshot querySnapshot = await Firestore.instance.collection('users').document(widget.userId).collection('projects')
    .document(widget.docID).collection('project_modules').getDocuments();
    setState(() {
        my_steps_status = querySnapshot.documents.map<Step>((document) {
          print(document.data['name']);
         print (document.data['status']);
          bool isOngoing=false;
          bool isCompleted=false;
         String status=document.data['status'];
          if(status=="Ongoing")
           isOngoing=true;
           if(status=="Completed") { 
              isCompleted=true;
          
             setState(() {
               _currentStep++;
            });}
             print (isOngoing);
             print(isCompleted);
             
    return Step(
     isActive: isCompleted || isOngoing,
     state: isCompleted?StepState.complete:StepState.indexed, 
     // Title of the Step
        title: new Text(document.data['name'],
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "Calibri",
                fontStyle: FontStyle.normal,
                fontSize: 18.0)),
        // Content, it can be any widget here.
        // Using basic Text for this example
        content: Row(   
          children: <Widget>[
        Column(   mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                 crossAxisAlignment: CrossAxisAlignment.start,
  

          children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text('-Started on:',
                        // document.data['start_date'],
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Calibri",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                      ),
                  ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text('-Completed on:',
                        // document.data['end_date'],
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Calibri",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                    ),
                      ),
                     
                                             
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text('-Payment Status:',
                        // document.data['payment_status'],
                        style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Calibri",
                              fontStyle: FontStyle.normal,
                              fontSize: 15.0),
                    ),
                          ),
                      
          ], 
          
        ),

          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.start,


            children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(document.data['start_date'],
               style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Calibri",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(top:8.0),
               child: Text(document.data['end_date'],
               style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Calibri",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),
            ),
             ),
            
             GestureDetector( 
                        onTap: (){
                          if(document.data['payment_status']== 'Paid'){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(userId: widget.userId,docID: widget.docID,)),);
                          }

                        },
         child:

         Padding(
           padding: const EdgeInsets.only(top:8.0),
           child: Text(document.data['payment_status'],
               style: const TextStyle(
                            color: const Color(0xFF0277BD),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Calibri",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),

              ),
         ),),
          ],)
          
                 
                      
             ] )  );

  
  }).toList();
    });
  
  
  }
  // init the step to 0th position
  int _currentStep = 0;
 


  void _onStepTapped(int value) {
   // if (value > progress) return;
    setState(() {
      _currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(

        // Title
          title: new Text(
            "Project Status",
            style: const TextStyle(
                color: const Color(0xfffffafa),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      // Body
      body: new Container(
          child:my_steps_status!=null? new Stepper(
            // Using a variable here for handling the currentStep
              currentStep: this._currentStep,
              
              // List the steps you would like to have
              steps: my_steps_status,
              // Define the type of Stepper style
              // StepperType.horizontal :  Horizontal Style
              // StepperType.vertical   :  Vertical Style
              type: StepperType.vertical,
              // Know the step that is tapped
              onStepTapped: _onStepTapped,
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue,
                    VoidCallback onStepCancel}) =>
                  Container()):new Container()),
    );
  }
}