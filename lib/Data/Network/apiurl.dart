import 'package:shared_preferences/shared_preferences.dart';
class Appurl {
  static const String Baseapiurl = "http://microlanpos.com/demo/api2/";
  static const String loginendpoint = Baseapiurl + "validate_signin";
  static const String categoryendpoint = Baseapiurl + "get_all_category";
  static const String productendpoint = Baseapiurl + "get_all_productdetails";
  static const String productimagesurl = Baseapiurl + "http://microlanpos.com/demo/products/";
  static const String categoryimagesurl = Baseapiurl + "http://microlanpos.com/demo/uploads/categoryimg/";
  static const String addtocartendpoint = Baseapiurl + "addItemToCart";
  static const String countincartendpoint = Baseapiurl + "count_in_cart";
  static const String itemincartendpoint = Baseapiurl + "item_in_cart";
  static const String searchproductendpoint = Baseapiurl + "search_products";
  static const String deletecartitemendpoint = Baseapiurl + "delete_cart";




}


