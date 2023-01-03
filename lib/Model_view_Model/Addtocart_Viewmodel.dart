import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../Data/Repositary/Postapi_Resositary.dart';
import '../Resources/Utils/Utils.dart';
import 'package:provider/provider.dart';

import 'Cart_view_Model.dart';

class Addtocart_Viewmodel with ChangeNotifier {
  final myrepo = Postapi_Resositary();




  Future<void> addtocart(BuildContext context, dynamic data) async {
    myrepo.addtocartitem(data).then((value) {
      //error: type 'int' is not a subtype of type 'string'
      //resolve: .tostring() use
      var Cartviewpd=Provider.of<Cartviewmodel>(context,listen: false);
      Cartviewpd.addcounter();
      // Utils.snacbar(value['status'].toString(), context);
      debugPrint("workingnow");
      debugPrint(value['status'].toString());
      Utils.snacbar("Add to Cart", context);

    }).onError((error, stackTrace) {
      debugPrint("atverror"+error.toString());
      // Utils.snacbar(error.toString(), context);
     print(error.toString());
    });
  }




}
