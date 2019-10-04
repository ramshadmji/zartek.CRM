import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyHomePage extends StatefulWidget {
  
final String docID,userId;

MyHomePage({this.docID,this.userId});

 

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

       
 

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    
    
    
    

    
    
    
    String url=document["url"];
    print(url);
    return ListTile(
      leading: Icon(
        Icons.picture_as_pdf,

        color:  const Color(0xFFD50000),
      ),
      title: Text(document["name"]),
    
      onTap:(
        
      ) 
       { 
        if(url!=null)
        {
         Fluttertoast.showToast(
        msg: 'Loading...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.white10,
        textColor: Colors.blueAccent,
        fontSize: 15.0
    );
   
           getFileFromUrl(url).then((f){
    setState(() {
         urlpdfPath=f.path;
     print(urlpdfPath); 
     
      Navigator.push(context, MaterialPageRoute(builder:(context)=>PdfViewPage(path:urlpdfPath),)
        );
    });
    
  });
          }

        },
    );
  }

 
 
 String urlpdfPath;
 
  @override
  void initState(){
  super.initState();
 
 getFileFromUrl("https://firebasestorage.googleapis.com/v0/b/list-66122.appspot.com/o/Project1%2F1103181300431510Time%20And%20Work%20.pdf?alt=media&token=d34092b9-2391-47c4-aafb-db9963d770d7").then((f){
    setState(() {
     urlpdfPath=f.path;
     print(urlpdfPath); 
    });
  });

  
}

  
  
  Future<File> getFileFromUrl(String url) async{
 try{
  
   
   var data=await http.get(url);
   var bytes=data.bodyBytes;
   var dir= await getApplicationDocumentsDirectory();
   File file=File("${dir.path}/pdf");
   File urlFile=await file.writeAsBytes(bytes);
   return urlFile;
  }
  catch(e)
 {
   throw Exception("error opening url file");
 }
  }
 
  @override
 Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       
      title: 'Welcome to Flutter',
      home: Scaffold(
        
        appBar: AppBar(
          title: Text('Invoice'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
        
      body: StreamBuilder(
          stream: Firestore.instance.collection('users').document(widget.userId).collection('projects')
    .document(widget.docID).collection('project_modules').where("payment_status", isEqualTo: "Paid").snapshots(),

          builder: (context, snapshot) {
            if (!snapshot.hasData)
             return Center(child:CircularProgressIndicator());
            return ListView.separated(
              separatorBuilder: (context,index)=>
              Divider(color: Colors.black),

              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }),
      )
    );}

}

 // /data/user/0/com.example.lastone/app_flutter/pdf

class PdfViewPage extends StatefulWidget{

 final String path;
 
 const PdfViewPage({Key key, this.path}) : super(key: key);

   
  
  @override

   _PdfViewPageState createState() => _PdfViewPageState();
}
  class  _PdfViewPageState extends State<PdfViewPage>
  {

    bool pdfReady= false;
    int  pages=0;
   @override
   Widget build(BuildContext context){
     var pdfView = PDFView(
  filePath:widget.path,
  enableSwipe: true,
  swipeHorizontal: true,
  autoSpacing: false,
  pageFling: false,
  onRender: (_pages) {
    setState(() {
      pages = _pages;
      pdfReady = true;
      //PDFViewController _pdfViewController;
     
    });
  },
  onError: (error) {
    print(error.toString());
  },
  onPageError: (page, error) {
    print('$page: ${error.toString()}');
  },
 
  onPageChanged: (int page, int total) {
    print('page change: $page/$total');
  },
);
     return Scaffold(
     appBar: AppBar(title: Text("Invoice"),),
     body:Stack(children: <Widget>[
       pdfView,
       !pdfReady?Center(child:CircularProgressIndicator(),):Offstage()
     ],
     ),
       
     );
     
   }
  }