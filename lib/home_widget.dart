import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:zartek/profile.dart';

import 'feedback.dart';
import 'profile.dart';
import 'project.dart';
import 'invoice.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
  return _HomeState();
  }
  
}
class _HomeState extends State<Home> {
  int _selectIndex=0;
  
   Widget pageOptions(int selectIndex ){
       
       switch (selectIndex) {
         case 0:return Project();
        break;
         case 1: return Invoice();
          break;
          case 2: return Feedbackk();
          break;
          case 3: return Profile();
         default:
       }
   }
    
   
 @override
 Widget build(BuildContext context) {
  
   return Scaffold(
     
     body: 
         
        pageOptions(_selectIndex), 
       bottomNavigationBar: 
       BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap:(int index) {
            setState((){
              _selectIndex=index;
          });// new
          },
          type: BottomNavigationBarType.fixed,
          
         // this will be set when a new tab is tapped
         items: [
           BottomNavigationBarItem(
             icon: new Icon(Icons.work),
             title: new Text('project',
             style: const TextStyle(
      color:  const Color(0xb2000000),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle:  FontStyle.normal,
      fontSize: 12.0
    )),
           ),
           BottomNavigationBarItem(
             icon: new Icon(Icons.assistant),
             title: new Text('Invoice',
             style: const TextStyle(
      color:  const Color(0xb2000000),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle:  FontStyle.normal,
      fontSize: 12.0
    )),
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.feedback),
             title: Text('Feedback',
             style: const TextStyle(
      color:  const Color(0xb2000000),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle:  FontStyle.normal,
      fontSize: 12.0
    ))
           ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
             title: new Text('profile',
             style: const TextStyle(
      color:  const Color(0xb2000000),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle:  FontStyle.normal,
      fontSize: 12.0
    ))
           )
         ],
       
       )
        );
        }    }
  
  


