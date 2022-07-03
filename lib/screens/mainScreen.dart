import 'package:charity/screens/GivenScreen.dart';
import 'package:charity/screens/addScreen.dart';
import 'package:charity/screens/phoneNumbersScreen.dart';
import 'package:charity/screens/searchScreen.dart';
import 'package:flutter/material.dart';

class mainScreen extends StatelessWidget {
  const mainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar:AppBar(
                  title: Text('Phone Numbers'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: SubjectSearch());
                        //uploadPdf(widget.subname, _tabController.index);
                        //print(_tabController.index);
                        // determineWhatToUpload(
                        //     _tabController.index, widget.subname);
                      },
                    )
                  ],
                  // leading: IconButton(
                  //   icon: Icon(
                  //     Icons.arrow_back,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                  bottom: TabBar(
                    //controller: _tabController,
                    indicatorColor: Theme.of(context).accentColor,
                    tabs: <Widget>[
                      Tab(
                        text: "ADD",
                        icon: Icon(Icons.add),
                      ),
                      Tab(
                        text: "PENDING",
                        icon: Icon(Icons.arrow_downward),
                      ),
                      Tab(
                        text: "GIVEN",
                        icon: Icon(Icons.check),
                      ),
                      
                    ],
                  ),
                ),
                 backgroundColor: Color(0xfff0f0f0),
          body: TabBarView( children: [
           addScreen(),
           phoneNumbersScreen(),
           GivenScreen(),
          
          ])),
        
        );
  }
}
