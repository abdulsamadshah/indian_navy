import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/Routes/RoutesName.dart';

import 'Model_view_Model/Addtocart_Viewmodel.dart';
import 'Model_view_Model/Auth_view_model.dart';
import 'Model_view_Model/Cart_view_Model.dart';
import 'Model_view_Model/Getapidata_view_Model.dart';
import 'Model_view_Model/Orderview_Model.dart';
import 'Model_view_Model/userviewmodel.dart';
import 'Resources/Routes/Route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authviewmodel()),
        ChangeNotifierProvider(create: (_) => Userviewmodel()),
        ChangeNotifierProvider(create: (_) => Getapidataviewmodel()),
        ChangeNotifierProvider(create: (_) => Cartviewmodel()),
        ChangeNotifierProvider(create: (_) => Addtocart_Viewmodel()),
        ChangeNotifierProvider(create: (_) => Orderviewmodel()),
      ],
      child: MaterialApp(
        title: 'Indian Navy',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: RoutesName.Splash_screen,
        onGenerateRoute: Routes.getroutes,
      ),
    );
  }
}
