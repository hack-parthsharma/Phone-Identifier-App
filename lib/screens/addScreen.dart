import 'package:charity/model/phoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class _LoginData {
  String email = '';
  String password = '';
}


class addScreen extends StatefulWidget {
  const addScreen({Key key}) : super(key: key);

  @override
  _addScreenState createState() => _addScreenState();
}

class _addScreenState extends State<addScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController editingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
     final Size screenSize = MediaQuery.of(context).size;
    return  SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(top:70),
            child: Container(
            padding: new EdgeInsets.all(20.0),
            child: new Form(
              key: this._formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: editingController,
                        keyboardType: TextInputType.number, // Use email input type for emails.
                        decoration: new InputDecoration(
                          //hintText: '957234573',
                          labelText: 'Enter the Phone Number...'
                          
                        )
                      ),
                       Container(
                    width: screenSize.width,
                    child: new RaisedButton(
                      padding: EdgeInsets.symmetric(vertical:17),
                      child: new Text(
                        'Save Phone Number',
                        style: new TextStyle(
                          fontSize: 15,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () 
                      { 
                        print("Phone number added is ${editingController.text}");
                          String phoneNumber = editingController.text.trim();
                          String feedback = "Phone Number Already Present";

                          if(phoneNumber.length != 10)
                          {
                            feedback = "please enter a valid Phone Number";
                          }else
                          {
                            if(PhoneNumbers.getObject(phoneNumber)==null)
                          {
                          feedback = "Phone Number Added!";
                          PhoneNumbers.addPhoneNumber(phoneNumber);
                          }

                          }

                          
                          editingController.clear();
                           Fluttertoast.showToast(
                            msg: feedback,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,

                          );


                      },
                      color: Colors.blue,
                    ),
                    margin: new EdgeInsets.only(
                      top: 20.0
                    ),
                    //  padding: const EdgeInsets.symmetric(
                    //           horizontal: 25.0, vertical: 15),
                  )
                    ],
                  ),
                  
                 
                
              
            )
          ),
      ),
    );
  }
}
