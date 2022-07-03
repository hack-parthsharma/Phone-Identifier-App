import 'package:flutter/material.dart';
import 'package:charity/model/phoneNumber.dart';

class SearchDisplayScreen extends StatefulWidget {
  final String query;
  const SearchDisplayScreen(this.query, {Key key}) : super(key: key);

  @override
  _SearchDisplayScreenState createState() => _SearchDisplayScreenState();
}

class _SearchDisplayScreenState extends State<SearchDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    List<PhoneNumber> shortListed = List.from(PhoneNumbers.allofthem
        .where((item) => item.number.startsWith(widget.query.toString())));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double safeAreaHorizontal = MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    double safeAreaVertical = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    double screenHeightWithoutSafeArea = height - safeAreaVertical;
    double screenWidthWithoutSafeArea = width - safeAreaHorizontal;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: screenHeightWithoutSafeArea,
      width: screenWidthWithoutSafeArea,
      child: ListView.builder(
          itemCount: shortListed.length,
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
                  print("DISMISSED FROM SEARCH LIST");
                  if(shortListed[index].isGiven==true)
                  {
                  fromGivenList(index,shortListed);

                  }else{
                  fromPendingList(index,shortListed);

                  }
                  // shortListed[index].isGiven ?
                  // :
                },
                background: shortListed[index].isGiven
                    ? Container(
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
                      )
                    : Container(
                        //margin: EdgeInsets.symmetric(horizontal:10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerStart,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                secondaryBackground: shortListed[index].isGiven
                    ? Container(
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
                      )
                    : Container(
                        //margin: EdgeInsets.symmetric(horizontal:10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: screenHeightWithoutSafeArea * 0.01,
                      top: screenHeightWithoutSafeArea * 0.005),
                  //color: Colors.yellow,
                  height: 80,
                  child: ListTile(
                    title: Container(
                      //color: Colors.blue,
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(shortListed[index].number,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(shortListed[index].serialNumber.toString()),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            );
          }),
    );
  }

  void fromPendingList(int index, List<PhoneNumber> shortListed) {
    setState(() {
      shortListed[index].isGiven = true;
    });
    PhoneNumbers.movePhoneNumberToGiven(shortListed[index]);
  }

  void fromGivenList(int index, List<PhoneNumber> shortListed) {
    setState(() {
      shortListed[index].isGiven = false;
    });
    PhoneNumbers.movePhoneNumberToPending(shortListed[index]);
  }
}
