import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Data/Response/Status.dart';
import 'package:indianavy_with_mvvmrestapi/Model/Cart.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/colors.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/fonts.dart';
import '../Model_view_Model/Addtocart_Viewmodel.dart';
import '../Model_view_Model/Auth_view_model.dart';
import '../Model_view_Model/Cart_view_Model.dart';
import '../Model_view_Model/Getapidata_view_Model.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model_view_Model/userviewmodel.dart';
import '../OfflineDb/cartlist.dart';
import '../Resources/Routes/RoutesName.dart';
import '../Resources/Utils/Utils.dart';

class Counterscreen extends StatefulWidget {
  const Counterscreen({Key? key}) : super(key: key);

  @override
  State<Counterscreen> createState() => _CounterscreenState();
}

class _CounterscreenState extends State<Counterscreen> {
  Getapidataviewmodel categorylistdata = Getapidataviewmodel();
  TextEditingController search_controller = TextEditingController();
  var size, height, width;
  var search = "";
  String userid = '';
  Cartdbhelper dbhelper = Cartdbhelper();
  int? userids, quantitys, packsizes, ids;
  String? finaltotalprices, productprices;

  @override
  void dispose() {
    super.dispose();
    // quantitys==0;
  }

  @override
  void initState() {
    // TODO: implement initState
    categorylistdata.getproductdatas();
    categorylistdata.getcategorydatas();
    loaduserid();
    super.initState();
  }

  void loaduserid() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('op_user_id') ?? '');
    });
  }

  Future<void> addtocartdialog(
      BuildContext context,
      String index,
      String packsize,
      String packsize1,
      String quantity,
      String productprice,
      String productname,
      String productimage,
      String productid) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var getcarddata = Provider.of<Cartviewmodel>(context);
          var addtocartpd = Provider.of<Addtocart_Viewmodel>(context);
          var userpd = Provider.of<Userviewmodel>(context);
          //Dialog box with customer
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pack Size",
                              style: TextStyle(fontFamily: PoppinssemiBolds),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7, top: 5),
                                child:
                                    Text("Gm ${packsize} / ₹ ${productprice}"),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7, top: 5),
                                child: Text("Gm ${packsize1}"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Quantity",
                              style: TextStyle(fontFamily: PoppinssemiBolds),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getcarddata.decreasequantity();
                                      getcarddata.removetotalprice(
                                          double.parse(productprice));
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 13),
                                          child: Icon(Icons.minimize_outlined),
                                        )),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Column(
                                      children: [
                                        Consumer<Cartviewmodel>(
                                          builder: (context, value, child) {
                                            return Text(
                                                "${value.getquantity()}");
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 6),
                                          child: Divider(
                                            height: 1,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      getcarddata.addquantity();
                                      getcarddata.addtotalprice(
                                          double.parse(productprice));
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Icon(Icons.add)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  //this right
                                  userids = int.parse(userid);
                                  print("useridss" + userids.toString());
                                } catch (e) {
                                  print("useridss" + e.toString());
                                }
                                //

                                try {
                                  //this right
                                  quantitys = int.parse(
                                      getcarddata.getquantity().toString());
                                  print("quantity" + quantitys.toString());
                                } catch (e) {
                                  print("quantity" + e.toString());
                                }

                                try {
                                  //wrong
                                  finaltotalprices =
                                      getcarddata.gettotalprice().toString();
                                  print("finaltotalprices" + finaltotalprices!);
                                } catch (e) {
                                  print("finaltotalprices" + e.toString());
                                }

                                try {
                                  //this right
                                  packsizes = int.parse(packsize.toString());
                                  print("packsizes" + packsizes.toString());
                                } catch (e) {
                                  print("packsizes" + e.toString());
                                }

                                try {
                                  //this right
                                  ids = int.parse(index);
                                  print("ids" + ids.toString());
                                } catch (e) {
                                  print("ids" + e.toString());
                                }

                                try {
                                  //this right
                                  // productprices = productprices.toString();
                                  print("productprices" + productprice);
                                } catch (e) {
                                  print("productprices" + e.toString());
                                }

                                double quantitydata =
                                    double.parse(quantitys.toString());
                                var price = productprice;
                                double prices = double.parse(price!);
                                print("prices:" + prices.toString());
                                print(
                                    "quantitydata:" + quantitydata.toString());

                                double totatamounts = quantitydata * prices;
                                print(
                                    "totalamounts:" + totatamounts.toString());

                                String totalamountsdata =
                                    totatamounts.toString();
                                print("totalamountsdatas:" +
                                    totalamountsdata.toString());

                                dbhelper
                                    .insertcartdata(Cart(
                                        id: ids,
                                        productid: productid,
                                        productname: productname,
                                        productimage: productimage,
                                        productprice: productprice,
                                        finaltotalprice: totalamountsdata,
                                        quantity: quantitys,
                                        pack_size: packsizes,
                                        userid: userids))
                                    .then((value) async {
                                  getcarddata.addcounter();
                                  getcarddata.addtotalprice(
                                      double.parse(productprice.toString()));
                                  SharedPreferences sp =
                                      await SharedPreferences.getInstance();
                                  await sp.remove("quantity").then((value) {
                                    print("removed quantity");
                                  }).onError((error, stackTrace) {
                                    print("remove quantity error");
                                  });
                                  Utils.showflushbar("Add to Cart", context);
                                  debugPrint("Data inserted");
                                });
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 50,
                                  width: 280,
                                  decoration: BoxDecoration(
                                    color: Appcolors.appprimarycolor,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Add to Cart",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var searchprovider = Provider.of<Authviewmodel>(context);
    var getcarddata = Provider.of<Cartviewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.appprimarycolor,
        title: Text("Counter"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.CartScreen);
            },
            child: Center(
              child: Badge(
                badgeContent: Consumer<Cartviewmodel>(
                  builder: (context, value, child) {
                    return Visibility(
                      visible: value.getcounter() == "0" ? false : true,
                      child: Text(
                        value.getcounter().toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_cart_sharp),
              ),
            ),
          ),
          SizedBox(
            width: 20.5,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: ChangeNotifierProvider<Getapidataviewmodel>(
                    create: (BuildContext context) => categorylistdata,
                    child: Consumer<Getapidataviewmodel>(
                      builder: (index, value, _) {
                        switch (value.categorylist.status) {
                          case Status.LOADING:
                            return Center(
                                child: CircularProgressIndicator(
                              color: Appcolors.appprimarycolor,
                            ));

                          case Status.ERROR:
                            return Center(
                                child: Text(
                                    value.categorylist.message.toString()));

                          case Status.COMPLETED:
                            return Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Container(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.categorylist.data!
                                        .categoryList!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Container(
                                          width: 140,
                                          child: Column(
                                            children: [
                                              Image.network(
                                                "http://microlanpos.com/demo/uploads/categoryimg/" +
                                                    value
                                                        .categorylist
                                                        .data!
                                                        .categoryList![index]
                                                        .imageName
                                                        .toString(),
                                                height: 100,
                                                width: 100,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                value
                                                    .categorylist
                                                    .data!
                                                    .categoryList![index]
                                                    .categoryName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        PoppinssemiBolds),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 40,
              //filter to all listview data
              child: CupertinoSearchTextField(
                controller: search_controller,
                onChanged: (String? value) {
                  print(value);
                  setState(() {
                    search = search_controller.text.toString();
                  });
                },
                autocorrect: true,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 1,
          ),
          Container(
            child: Expanded(
              child: ChangeNotifierProvider<Getapidataviewmodel>(
                create: (BuildContext context) => categorylistdata,
                child: Consumer<Getapidataviewmodel>(
                  builder: (index, value, _) {
                    switch (value.productlist.status) {
                      case Status.LOADING:
                        return Center(
                            child: CircularProgressIndicator(
                          color: Appcolors.appprimarycolor,
                        ));

                      case Status.ERROR:
                        return Center(
                            child: Text(value.productlist.message.toString()));
                      case Status.COMPLETED:
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                              child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Expanded(
                                child: GridView.builder(
                                    itemCount: value.productlist.data!
                                        .productDetails!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,

                                      //heigh increased
                                      mainAxisExtent: 180,
                                    ),
                                    itemBuilder: (context, index) {
                                      //search filter condition
                                      late String position = value
                                          .productlist
                                          .data!
                                          .productDetails![index]
                                          .productName
                                          .toString();
                                      if (search_controller.text.isEmpty) {
                                        return Card(
                                          elevation: 5,
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 1,
                                            // width: double.infinity,

                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: SizedBox(
                                                        height: 40,
                                                        width: 50,
                                                        child: Image.network(
                                                          "http://microlanpos.com/demo/products/" +
                                                              value
                                                                  .productlist
                                                                  .data!
                                                                  .productDetails![
                                                                      index]
                                                                  .imageName
                                                                  .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Center(
                                                        child: Text(
                                                          value
                                                              .productlist
                                                              .data!
                                                              .productDetails![
                                                                  index]
                                                              .productName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  PoppinssemiBolds),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        value
                                                            .productlist
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                PoppinssemiBolds),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        var indexs =
                                                            index.toString();
                                                        var packSize = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .packSize
                                                            .toString();
                                                        var packSize1 = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .packSize1
                                                            .toString();
                                                        var productId = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .productId
                                                            .toString();
                                                        var productName = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .productName
                                                            .toString();
                                                        var imageName =
                                                            "http://microlanpos.com/demo/products/" +
                                                                value
                                                                    .productlist
                                                                    .data!
                                                                    .productDetails![
                                                                        index]
                                                                    .imageName
                                                                    .toString();
                                                        var price = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .price
                                                            .toString();
                                                        var stockQty = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .stockQty
                                                            .toString();
                                                        addtocartdialog(
                                                            context,
                                                            indexs,
                                                            packSize,
                                                            packSize1,
                                                            stockQty,
                                                            price,
                                                            productName,
                                                            imageName,
                                                            productId);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0,
                                                                top: 5),
                                                        child: Container(
                                                          height: 25,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    PoppinssemiBolds),
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (position
                                          .toLowerCase()
                                          .contains(search_controller.text
                                              .toLowerCase())) {
                                        return Card(
                                          elevation: 5,
                                          child: Container(
                                            // height: MediaQuery.of(context).size.height * 1,
                                            // width: double.infinity,

                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: SizedBox(
                                                        height: 40,
                                                        width: 50,
                                                        child: Image.network(
                                                          "http://microlanpos.com/demo/products/" +
                                                              value
                                                                  .productlist
                                                                  .data!
                                                                  .productDetails![
                                                                      index]
                                                                  .imageName
                                                                  .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Center(
                                                        child: Text(
                                                          value
                                                              .productlist
                                                              .data!
                                                              .productDetails![
                                                                  index]
                                                              .productName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  PoppinssemiBolds),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        value
                                                            .productlist
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                PoppinssemiBolds),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        var indexs =
                                                            index.toString();
                                                        var packSize = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .packSize
                                                            .toString();
                                                        var packSize1 = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .packSize1
                                                            .toString();
                                                        var productId = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .productId
                                                            .toString();
                                                        var productName = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .productName
                                                            .toString();
                                                        var imageName =
                                                            "http://microlanpos.com/demo/products/" +
                                                                value
                                                                    .productlist
                                                                    .data!
                                                                    .productDetails![
                                                                        index]
                                                                    .imageName
                                                                    .toString();
                                                        var price = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .price
                                                            .toString();
                                                        var stockQty = value
                                                            .productlist!
                                                            .data!
                                                            .productDetails![
                                                                index]
                                                            .stockQty
                                                            .toString();
                                                        addtocartdialog(
                                                            context,
                                                            indexs,
                                                            packSize,
                                                            packSize1,
                                                            stockQty,
                                                            price,
                                                            productName,
                                                            imageName,
                                                            productId);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0,
                                                                top: 5),
                                                        child: Container(
                                                          height: 25,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    PoppinssemiBolds),
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                            ],
                          )),
                        );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
