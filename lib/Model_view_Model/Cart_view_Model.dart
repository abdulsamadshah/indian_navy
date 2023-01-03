import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Cart.dart';
import '../OfflineDb/cartlist.dart';

class Cartviewmodel with ChangeNotifier {
  Cartdbhelper dbhelper = Cartdbhelper();
  int _quantity = 1;

  int get quantit => _quantity;

  double _totalprice = 0;

  double get totalprice => _totalprice;

  int _counter = 0;

  int get counter => _counter;

  double _finaltotalprice = 0;

  double get finaltotalprice => _finaltotalprice;

  setprefcart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("cartitem", counter);
    preferences.setInt("quantity", quantit);
    preferences.setDouble("totalprice", totalprice);
    preferences.setDouble("finaltotalprice", finaltotalprice);
  }

  getprefcart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getInt("cartitem") ?? 0;
    preferences.getInt("quantity") ?? 0;
    preferences.getDouble("totalprice");
    preferences.getDouble("finaltotalprice");
  }

  addquantity() {
    _quantity++;
    setprefcart();
    print(_quantity);
    notifyListeners();
  }

  decreasequantity() {
    if (_quantity > 1) {
      _quantity--;
      setprefcart();
      notifyListeners();
    } else {
      print("somethingisgoodqty");
    }
  }

  int getquantity() {
    getprefcart();
    return _quantity;
  }

  addcounter() {
    _counter++;
    setprefcart();
    print(_counter);
    notifyListeners();
  }

  int getcounter() {
    getprefcart();
    return _counter;
  }

  void removecounter() {
    _counter--;
    setprefcart();
    notifyListeners();
  }

  addtotalprice(double productprice) {
    _totalprice = _totalprice + productprice;
    print("Alltotalprice${productprice}");
    setprefcart();
    notifyListeners();
  }

  removetotalprice(double productprice) {
    _totalprice = _totalprice - productprice;
    setprefcart();
    notifyListeners();
  }

  double gettotalprice() {
    getprefcart();
    return _totalprice;
  }

  double settotalprice(double finalamount) {
    print("finaltotalamounts:${finalamount}");
    return _finaltotalprice;
  }

  //read the to sqlite and get the data to this method
  late Future<List<Cart>> _cart;

  Future<List<Cart>> getdata() async {
    _cart = dbhelper.getcartdata();
    return _cart;
  }
}
