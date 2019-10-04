import 'package:flutter/material.dart';
import 'cardview.dart';

import 'package:zartek/webview.dart';




class Project extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Prjt();
      }  
    }
    
    class Prjt extends State<Project>{
     
    
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(appBar: AppBar(
       title: Text('Your Project',
        style: const TextStyle(
    color:  const Color(0xfffffafa),
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontStyle:  FontStyle.normal,
    fontSize: 20.0
  )),),
  floatingActionButton: FloatingActionButton.extended(
             tooltip: 'Increment',
         icon:   Icon(Icons.add,color: Color(0xffffffff),),
         label: Text(
                  "Add New Project", style: const TextStyle(
                    color:  const Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle:  FontStyle.normal,
                    fontSize: 10.0),),
           
    onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Web()));

    }
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

 
      body:CardV(page: ProjectPages.project,
              ),
     
      
 
  );
  }}
