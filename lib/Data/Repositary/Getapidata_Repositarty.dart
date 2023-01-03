import 'package:indianavy_with_mvvmrestapi/Data/Network/BaseapiServices.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Network/NetworkapiResponse.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Network/apiurl.dart';

import '../../Model/Category.dart';
import '../../Model/Product.dart';

class GetapidataRepositary {
  Baseapiservices apiserives = NetworkapiResponse();

  Future<Category> getcategorydata() async {
    try {
      dynamic response =
          await apiserives.Getapiresponse(Appurl.categoryendpoint);
      return response = Category.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<Product> getproductdata() async {
    try {
      dynamic response =
          await apiserives.Getapiresponse(Appurl.productendpoint);
      return response = Product.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
