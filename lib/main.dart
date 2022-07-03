import 'package:charity/screens/mainScreen.dart';
import 'package:charity/screens/phoneNumbersScreen.dart';
import 'package:flutter/material.dart';
import 'package:charity/model/phoneNumber.dart';

void main() { 
   WidgetsFlutterBinding.ensureInitialized();
   PhoneNumbers();
  runApp(MyApp() );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number Identifier',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Phone Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  
   

  @override
  Widget build(BuildContext context) {
  
    return mainScreen();
  }
}
