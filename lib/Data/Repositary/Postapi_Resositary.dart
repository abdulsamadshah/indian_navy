import 'package:flutter/cupertino.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Network/BaseapiServices.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Network/NetworkapiResponse.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Network/apiurl.dart';
import 'package:http/http.dart';

import '../../Resources/Utils/Utils.dart';

class Postapi_Resositary {
  Baseapiservices authapiservices = NetworkapiResponse();

  Future<dynamic> loginauthenticate(dynamic data) async {
    print("hereis");
    final response =
        authapiservices.Postapiresponse(Appurl.loginendpoint, data);
    return response;
  }

  Future<dynamic> addtocartitem(dynamic data) async {
    try {
      debugPrint("addtocartres");
      dynamic response =
          await authapiservices.Postapiresponse(Appurl.addtocartendpoint, data);
      return response;
    } catch (e) {
      debugPrint("addtocartereps" + e.toString());
      throw e;
    }
  }
}
