import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orderviewmodel with ChangeNotifier{


  String _ordernumber = "";

  String get ordernumber => _ordernumber;

//setorder to first of all setordertopref then getorder to pref and setordernumber and getgetordernumber
  setorderprefitems() async {
    DateTime data = DateTime.now();

    var curentdatetime = data.hour.toString() +
        data.minute.toString() +
        data.second.toString() +
        data.day.toString() +
        data.month.toString() +
        data.year.toString();
    String currentordernumbers = "POS${curentdatetime}";
    _ordernumber = currentordernumbers.toString();
    print("POS${curentdatetime}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ordernumber", _ordernumber);
  }

  getprefordernumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _ordernumber = preferences.getString(
      "ordernumber",) ?? "";
  }

  String setordernumber() {
    setorderprefitems();
    notifyListeners();
    return _ordernumber;
  }

  String getordernumber() {
    getprefordernumber();
    notifyListeners();
    return _ordernumber;
  }

}