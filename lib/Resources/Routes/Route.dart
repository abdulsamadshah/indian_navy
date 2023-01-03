import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/View/Counter_screen.dart';
import 'package:indianavy_with_mvvmrestapi/View/Login_screen.dart';
import 'package:indianavy_with_mvvmrestapi/View/homescreen.dart';

import '../../View/Billpage_Screen.dart';
import '../../View/Cart_screen.dart';
import '../../View/Splash_screen.dart';
import '../../View/searchscreen.dart';
import 'RoutesName.dart';

class Routes {
  static Route<dynamic> getroutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homescreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Homescreen());

      case RoutesName.Login_screen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Login_screen());

      case RoutesName.Splash_screen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Splash_screen());

      case RoutesName.Counterscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Counterscreen());

      case RoutesName.searchscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Searchscreen());

      case RoutesName.CartScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => Cart_Screen());

      case RoutesName.Billpage_Screen:
        return MaterialPageRoute(builder: (BuildContext context)=>Billpage_Screen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => Homescreen());
    }
  }
}
