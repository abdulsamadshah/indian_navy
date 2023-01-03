import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Usermodel.dart';

class Userviewmodel with ChangeNotifier {
  Future<bool> saveuser(String email, String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", email);
    sp.setString("password", password);

    notifyListeners();
    return true;
  }

  Future<bool> saveuseralldata(String email, String op_user_id,
      String user_name, String contact_no, String address) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", email);
    sp.setString("op_user_id", op_user_id);
    sp.setString("user_name", user_name);
    sp.setString("contact_no", contact_no);
    sp.setString("address", address);

    notifyListeners();
    return true;
  }


  String _username = "";

  String get username => _username;




  getuserdata() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _username = sp.getString("user_name") ?? '';
    print(_username);
  }







  // String? userid = sp.getString("op_user_id");
  // String? username = sp.getString("user_name");
  // String? contactno = sp.getString("contact_no");
  // String? address = sp.getString("address");

  // Future<bool> getuser() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.getString("email");
  //   sp.getString("password");
  //   notifyListeners();
  //   return true;
  // }

  Future<bool> removeuser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove("email");
    await sp.remove("password");
    notifyListeners();
    return true;
  }
}
