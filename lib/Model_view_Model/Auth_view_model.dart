import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Response/Apiresponse.dart';
import 'package:indianavy_with_mvvmrestapi/Model/Usermodel.dart';
import 'package:indianavy_with_mvvmrestapi/Model_view_Model/userviewmodel.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/Routes/RoutesName.dart';
import 'package:provider/provider.dart';
import '../Data/Repositary/Postapi_Resositary.dart';
import '../Resources/Utils/Utils.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Authviewmodel with ChangeNotifier {
  Postapi_Resositary repo = Postapi_Resositary();
  Apiresponse<dynamic> response = Apiresponse.loading();

  ///Generate MD5 hash
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    print(digest);
    // return hex.encode(digest.bytes);
    return digest.bytes;
  }

  Future<void> loginauthenticate(
      BuildContext context, dynamic data, String userid, passoword) async {
    repo.loginauthenticate(data).then((value) {
      final userpref = Provider.of<Userviewmodel>(context, listen: false);

      //here is save the userid and password
      userpref.saveuser(userid, passoword).then((value) {
        print(value.toString());
      });

      userpref.saveuseralldata(value['email'], value['op_user_id'],
          value['user_name'], value['contact_no'], value['address']);

      //get the user satus and othres data
      Utils.snacbar(value['msg'].toString(), context);
      Navigator.pushNamed(context, RoutesName.homescreen);
    }).onError((error, stackTrace) {
      Utils.snacbar(error.toString(), context);
    });
  }
}
