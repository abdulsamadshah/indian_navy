import 'package:flutter/cupertino.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Response/Apiresponse.dart';

import '../Data/Repositary/Getapidata_Repositarty.dart';
import '../Model/Category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Product.dart';
import '../Resources/Utils/Utils.dart';

class Getapidataviewmodel with ChangeNotifier {





  GetapidataRepositary myrepo = GetapidataRepositary();
  Apiresponse<Category> categorylist = Apiresponse.loading();

  void setcategory(Apiresponse<Category> response) {
    categorylist = response;
    notifyListeners();
  }

  Future<void> getcategorydatas() async {


    setcategory(Apiresponse.loading());

    myrepo.getcategorydata().then((value) {
      setcategory(Apiresponse.completed(value));
    }).onError((error, stackTrace) {
      setcategory(Apiresponse.error(error.toString()));
    });
  }

  //product list data
  Apiresponse<Product> productlist = Apiresponse.loading();

  void setproduct(Apiresponse<Product> response) {
    productlist = response;
    notifyListeners();
  }

  Future<void> getproductdatas() async {
    setproduct(Apiresponse.loading());

    myrepo.getproductdata().then((value) {
      setproduct(Apiresponse.completed(value));
    }).onError((error, stackTrace) {
      setproduct(Apiresponse.error(error.toString()));
    });
  }
}
