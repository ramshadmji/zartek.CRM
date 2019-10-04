import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek/home_widget.dart';
import 'forgotPage.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Login extends StatefulWidget {
 


  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {




//dec
  String _email;
  String _password;


  final formKey=new GlobalKey<FormState>();
  
  //Validate save

 Future<void> validateAndSave() async {
     
    final form=formKey.currentState;
    
    if(form.validate()){
      form.save();
      try{ 
        //firebase
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

      }
      catch(e){
        Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xfff2f2f2),
        textColor: Colors.red,
        fontSize: 14.0
    );
       print(e.message);
       
      }
    }
      

     


    }

  @override
  Widget build(BuildContext context) {


 //Email 

    Widget _showEmailInput() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),

    child: new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value)=> value.isEmpty ? 'Email cant be empty':null,
      //saving
      onSaved: (value)=> _email = value,
      decoration: new InputDecoration(
          
          labelText: 'username',
          fillColor: Colors.blue
          
        ),
      
    ),
  );
}

//Password

Widget _showPasswordInput() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    child: new TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      validator: (value)=> value.isEmpty ? 'Password cant be empty' : null,
      //saving
      onSaved: (value) => _password = value,
      decoration: new InputDecoration(
        
          labelText: 'password',
          fillColor: Colors.blue,
          
          ),
      
    ),
  );
}

//Text

Widget _logoText()=> new Text('LOGIN',
                    textAlign: TextAlign.center,
                    

                    style: const TextStyle(
                      


                        color:  const Color(0xff2f80ed),

                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle:  FontStyle.normal,
                        fontSize: 22.0
                        
                    ),
  );

  

  //Primary btn

  Widget _showPrimaryButton() {
  return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new MaterialButton(
        elevation: 6.0,
        minWidth: 130.0,
        height: 40.0,
        color: Colors.blue,
         shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),),
        child: new Text('Login',
                style: new TextStyle(fontSize: 22.0, color: Colors.white)),
           
        onPressed: (){
          validateAndSave();
        },
      ));}

//sec button

   Widget _showSecondaryButton() {
  return new FlatButton(
    child: new Text('Forgot Your Password ?',
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400,fontFamily: "Roboto")),
        textColor: Colors.blue,
        
    onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPage(),));
    },
  );
}


//Body
    return    Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: false,
           body: new Stack(
       children: <Widget>[
          new Column(
            children: <Widget>[
              Expanded(
                flex: 35,
                              child: new Container(
                  decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius: new BorderRadius.only(
                              bottomLeft:  const  Radius.circular(40.0),
                              bottomRight: const  Radius.circular(40.0))),
                  height: 280,
                  

                  child: new Text('Zartek',
                    textAlign: TextAlign.center,

                    style: const TextStyle(

                        color:Colors.white,
                       fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle:  FontStyle.normal,
                        fontSize: 64.0,

                    ),

                  ),
                  
                  alignment: Alignment.center,
                 // color : Color(0xff4886ff),
                  




                ),
              ),
              Expanded(
                flex: 45,
                child: new Container())
          ],

          ),
      Column(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: SizedBox(height: 80,)),
          
      Expanded(
        flex: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
                child: Card(elevation: 6.0,
                               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            color : Color(0xfff2f2f2),
                            child: SingleChildScrollView(
                              child:new Form(
                                key: formKey,
                     child: new Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                         SizedBox(height: 15,),
                        _logoText(),
                         SizedBox(height:35,),
                        _showEmailInput(),
                         SizedBox(height: 5,),
                        _showPasswordInput(),
                        SizedBox(height: 5,),
                         _showSecondaryButton(),
                         SizedBox(height: 5,),
                        
                        //SizedBox(height: ,),
                        _showPrimaryButton(),
                                                 SizedBox(height: 15,),
                 
                                                 

                      ],),),
                            ),
                
                          ),
              ),
      ),
      
        ],
      ),
        ],
      ),
    );


  
  }

}
