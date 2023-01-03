import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Response/Apiexception.dart';

import 'BaseapiServices.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NetworkapiResponse extends Baseapiservices {
  @override
  Future Getapiresponse(String url) async {
    try {
      dynamic responsejson;
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      return responsejson = returnresponse(response);
    } catch (e) {
      throw Fetchdataexception('No Internet Connection');
    }
  }

  @override
  Future Postapiresponse(String url, dynamic data) async {
    dynamic responsejson;
    try {
      Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));
      debugPrint("postapiresp:" + response.toString());
      responsejson = returnresponse(response);
    } on SocketException {
      throw Fetchdataexception('No Internet Connection');
    }

    return responsejson;
  }

  dynamic returnresponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responsedata = jsonDecode(response.body);
        print(responsedata);
        return responsedata;

      case 400:
        print("this1" + response.statusCode.toString());
        throw BadrequestDataexception('Invalid Request');

      case 501:
        print("this2" + response.statusCode.toString());
        throw UserauthorizedException('Userauthorized Request');

      case 500:
        print("this1" + response.statusCode.toString());
        throw UserauthorizedException('Userauthorized Request');

      default:
        throw Fetchdataexception("Error occured while communating with server" +
            'with status code' +
            response.statusCode.toString());
    }
  }
}
