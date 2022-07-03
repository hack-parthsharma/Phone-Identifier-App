import 'package:charity/model/phoneNumber.dart';
import 'package:flutter/material.dart';

class GivenScreen extends StatefulWidget {
  const GivenScreen({Key key}) : super(key: key);

  @override
  _GivenScreenState createState() => _GivenScreenState();
}

class _GivenScreenState extends State<GivenScreen> {
 @override
  Widget build(BuildContext context) {
    print(PhoneNumbers.givenList);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double safeAreaHorizontal = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    double safeAreaVertical = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    double screenHeightWithoutSafeArea = height - safeAreaVertical;
    double screenWidthWithoutSafeArea = width - safeAreaHorizontal;

    
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: screenHeightWithoutSafeArea,
      width:screenWidthWithoutSafeArea,
      child:ListView.builder(
            itemCount:  PhoneNumbers.givenList.length,
            itemBuilder: (context, index) {
              //final item = widget.userSub[index].name;
              return Container(
                height: screenHeightWithoutSafeArea * 0.08,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 25),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 25)
                    ]),
                child: Dismissible(
                 key: UniqueKey(),
                  onDismissed: (direction) {
                   print("DISMISSED FROM GIVEN LIST");
                   
                    setState(() {
                      PhoneNumbers.givenList[index].isGiven = false;
                    });  
                     PhoneNumbers.movePhoneNumberToPending(PhoneNumbers.givenList[index]);
                  },
                  background: Container(
                    //margin: EdgeInsets.symmetric(horizontal:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerStart,
                    child: Icon(
                      Icons.block,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    //margin: EdgeInsets.symmetric(horizontal:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(
                      Icons.block,
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: screenHeightWithoutSafeArea*0.01, top: screenHeightWithoutSafeArea*0.005),
                    //color: Colors.yellow,
                    height: 80,
                    child: ListTile(
                      title: Container(

                        //color: Colors.blue,
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(PhoneNumbers.givenList[index].number,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              
                              fontSize: 20,
                            )),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(PhoneNumbers.givenList[index].serialNumber.toString()),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              );
            }),
     
  
    );
  }
}