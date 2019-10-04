import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zartek/chat.dart';


import 'package:zartek/status.dart';
import 'card_model.dart';
import 'invoice_pdf.dart';

enum ProjectPages{project,invoice,feedback}

class CardV extends StatefulWidget
{
 final ProjectPages page;
  CardV({this.page});

  @override
  CardView createState() => CardView(); 
    
}

    class CardView extends State<CardV> {
      

      @override
  void initState() {
 
    super.initState();

    inputData();
  }

     // final CurrentStatus currentStatus;

      CardView();     
      
      double i=0;
      FirebaseUser user;
     String userid;
      CollectionReference collectionReference ;

     void inputData() async {
      FirebaseAuth auth=FirebaseAuth.instance;
               user = await auth.currentUser();
       userid=user.uid;
      
      setState(() {
      collectionReference= Firestore.instance.collection('users').document(user.uid).collection('projects');

      });
    
  }

  @override
  Widget build(BuildContext context) {
    
    Stream<QuerySnapshot> stream;
  if(collectionReference!=null)
    stream = collectionReference.snapshots();
    return collectionReference!=null?
    
       Padding(
        // Padding before and after the list view:
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new StreamBuilder(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
              //    if (!snapshot.hasData) return CircularProgressIndicator();
                  return Stack(
                    children: <Widget>[snapshot.hasData?
                      new ListView(
                        children: snapshot.data.documents.map((document) {
                          //data
                         // document.documentID
                         String docID=document.documentID;
                          CurrentStatus currentItem=CurrentStatus.fromMap(document.data);
                        int p = currentItem.per;
                        i = (p /100);
                     //   print(docID);
                          return new Column(children: <Widget>[
                
                               GestureDetector(
                               onTap: (){ if(widget.page==ProjectPages.project)
                               {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome(docID:docID,userId:userid,)),
                                           );
                               }
                               else if(widget.page==ProjectPages.invoice)
                               {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage(docID: docID,userId:userid,)),
                                          );
                               }
                               else if(widget.page==ProjectPages.feedback)
                               {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()),
                                          );              
                               }

                               },

                 child:  Card(
                       
        
                       margin: const EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 30.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                 ), 
                 
                child: Container(
                       width: 340,
                        // height: 149,
                        constraints: BoxConstraints.expand(height: 160.0),
                       decoration: new BoxDecoration(boxShadow: [new BoxShadow(color: Colors.black,
                       blurRadius: 10.0,
                        offset: new Offset(3.0, 3.0),)],
                        borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(32.0),
                        bottomLeft: const Radius.circular(32.0),
                        topRight: const Radius.circular(32.0),
                        bottomRight: const Radius.circular(32.0),
                       ),
                        gradient: new LinearGradient(
                          colors: [ const Color(0xFF0277BD), const Color(0xff00E5FF)],
                        begin:  Alignment.topCenter,
                        end:  Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.repeated
                ),
              ),
  
                      
                padding: EdgeInsets.all(16.0),
                      child:Row(
                        children: <Widget>[
                         Expanded(
                           flex: 80,

                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                                              //prjname
                                              currentItem.prjname!=null?
                                                 Text(
                                                   
                                         currentItem.prjname,
                                               
                                        style: const TextStyle(
                                        color:  const Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Roboto",
                                         fontStyle:  FontStyle.normal,
                                          fontSize: 18.0)
                                            
                                      ):new Container(),
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 25.0),
                                                 child: Text( 'Status:',
                                          style: const TextStyle(
                                          color:  const Color(0xffe5e5e5),
                                          
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 13.0
                                          ),
                                        textAlign:TextAlign.left ,),
                                               ),
                                               //status
                                               currentItem.status!=null?
                                        Text( currentItem.status,
                                        style: const TextStyle(
                                          color:  const Color(0xffffffff),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Roboto",
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 16.0
                                        )):new Container()
                             ],
                           ),
                         ),
                         Expanded(
                         flex: 25,
                             child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               
                               crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child:  CircularPercentIndicator(
                                           radius: 47.0,
                                           lineWidth: 4.0,
                                           animation: true,
                                            percent: i,
                                            progressColor: Colors.white,
                                            //percentage
                                            center:  currentItem.per!=null?Text("${currentItem.per}%",
                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.white),):new Container(),
                                           
                                            footer: new Text( "Completed",style: const TextStyle(
                                                            color:  const Color(0xffe5e5e5),
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Roboto",
                                                            fontStyle:  FontStyle.normal,
                                                            fontSize: 13.0
                                                          )
                               
                                                          ),
                                           circularStrokeCap: CircularStrokeCap.round,
                              
                                             ),
                                  ),
                                      
                                     
                                  new  Align(alignment: Alignment.bottomLeft,child: Text('End Date',
                                         textAlign: TextAlign.left,
                                          style: const TextStyle(
                                          color:  const Color(0xffe5e5e5),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 13.0
                                        )),),
                                                    
  
                                                      //enddate
                                 new Align(alignment: Alignment.bottomLeft,
                                 child:currentItem.end!=null?Text(currentItem.end,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                      color:  const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                       fontStyle:  FontStyle.normal,
                                      fontSize: 16.0
                                    )):new Container(),)  ],
                              
                      ) ,
                           
                         )
                         
                      
                        ],)
                
                 
    
              )
              )),

              
                
                          
              ],);
                        }).toList(),
                      ):new Container(),
                      Center(child: !snapshot.hasData?new CircularProgressIndicator():new Container())
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ):new Container();
  }

  }

    

          
    
