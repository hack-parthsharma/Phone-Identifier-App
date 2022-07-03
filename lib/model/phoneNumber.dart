import 'package:charity/helpers/db_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
String table = 'user_subjects';
class PhoneNumber
{
   String number;
   int serialNumber;
  bool isGiven;

  PhoneNumber(this.number,this.serialNumber,this.isGiven);

}

class PhoneNumbers
{
  static Map<int,PhoneNumber> items = 
  {
  };

  static List<PhoneNumber> pendingList = [];
  static List<PhoneNumber>  givenList = [];

  static List<PhoneNumber> allofthem = [];

  PhoneNumbers() 
  {
    print("Constructor called , sorting initiated");
    initPrefs();  
    
  }

  initPrefs() async {
     final dataList = await DBHelper.getData(table);
     if(dataList!=null)
     {
      print("DATABASE NOT NULL");
      print(dataList);
      
      
     dataList.map((item)
    {
      return PhoneNumbers.items.update(
      item["serialNumber"],
      (existingValue) => PhoneNumber(item["phoneNumber"],item["serialNumber"],item["isGiven"]!=0),
      ifAbsent: () => PhoneNumber(item["phoneNumber"],item["serialNumber"],item["isGiven"]!=0),
        );
      
    }).toList();

     }else{print("DATABASE IS NULL");}


    PhoneNumbers.items.forEach((key, value) {
      if (value.isGiven == false) {
        pendingList.add(value);
      }else{
        givenList.add(value);
      }

      allofthem.add(value);
    });
    print(pendingList);
    print(allofthem);
    print(items);
    
  }


  

  static movePhoneNumberToGiven(PhoneNumber phoneNumber) async
  {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if(pendingList.contains(phoneNumber))
    {
    pendingList.remove(phoneNumber);
    givenList.add(phoneNumber);
    items.update(
      phoneNumber.serialNumber,
      (existingValue) => phoneNumber,
      ifAbsent: () => phoneNumber
    );
    //  prefs.setString("phoneNumbers", json.encode(encodeMap(items)));
     DBHelper.update(table,{
      'phoneNumber': phoneNumber.number,
      'serialNumber':phoneNumber.serialNumber,
      'isGiven' :   phoneNumber.isGiven ? 1 : 0,
    },
    phoneNumber.serialNumber);
    }
  }

  static movePhoneNumberToPending(PhoneNumber phoneNumber) async
  {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if(givenList.contains(phoneNumber))
    {
    givenList.remove(phoneNumber);
    pendingList.add(phoneNumber);
    items.update(
      phoneNumber.serialNumber,
      (existingValue) => phoneNumber,
      ifAbsent: () => phoneNumber
    );
    //  prefs.setString("phoneNumbers", json.encode(encodeMap(items)));
     DBHelper.update(table,{
      'phoneNumber': phoneNumber.number,
      'serialNumber':phoneNumber.serialNumber,
      'isGiven' :   phoneNumber.isGiven ? 1 : 0,
    },
    phoneNumber.serialNumber);
    }

  }

  static addPhoneNumber(String number) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PhoneNumber phoneNumber = PhoneNumber(number,items.length + 1,false); 
     items.update(
      items.length + 1,
      (existingValue) => phoneNumber,
      ifAbsent: () => phoneNumber
      );
      pendingList.add(phoneNumber);
      allofthem.add(phoneNumber);
      // prefs.setString("phoneNumbers", json.encode(encodeMap(items)));
      DBHelper.insert(table,{
      'phoneNumber': phoneNumber.number,
      'serialNumber':phoneNumber.serialNumber,
      'isGiven' :   phoneNumber.isGiven ? 1 : 0,
    },);
     final dataList = await DBHelper.getData(table);
     print("!@@@@@");
     print(dataList);
    

  }

  static getPhoneNumberBySerialNumber(int serialNumber)
  {
    var selectedItem = items.keys.firstWhere((key) => key==serialNumber, orElse: () => null);
    return items[selectedItem];
  }

  static getObject(String phoneNumber)
  {
    var selectedItem = items.keys.firstWhere((key) => items[key].number==phoneNumber, orElse: () => null);
    return items[selectedItem];
  }

}