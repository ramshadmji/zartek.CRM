import 'package:flutter/material.dart';
import 'cardview.dart';





class Invoice extends StatefulWidget {
  
  


  @override
  Invoice1 createState() => new Invoice1();
}

class Invoice1 extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
 {
    
    return Scaffold(
     appBar: AppBar(
       title: Text('Invoice',
        style: const TextStyle(
    color:  const Color(0xfffffafa),
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontStyle:  FontStyle.normal,
    fontSize: 20.0
  )),
     ),
   
    
    body:CardV(page: ProjectPages.invoice,
                     ),
                      );
  }

  }
}
