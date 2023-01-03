import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/colors.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/fonts.dart';
import 'package:indianavy_with_mvvmrestapi/View/Billpage_Screen.dart';

import '../Model/Cart.dart';
import '../Model_view_Model/Cart_view_Model.dart';
import '../OfflineDb/cartlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  Cartdbhelper dbhelper = Cartdbhelper();
  int? quantitydatas;

  @override
  Widget build(BuildContext context) {
    var carts = Provider.of<Cartviewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.appprimarycolor,
        title: Text("Item in Cart"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: carts.getdata(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        // child:Text("Card is empty"),
                        child: Container(
                          child: Image.asset("assets/images/cartempty.png"),
                        ),
                      );
                    }
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 145,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, bottom: 7),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Center(
                                                child: Container(
                                                  height: 70,
                                                  width: 70,
                                                  child: Image.network(snapshot
                                                      .data![index]
                                                      .productimage),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, left: 7),
                                                child: Container(
                                                  width: 130,
                                                  height: 110,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 5,
                                                        ),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .productname,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  PoppinssemiBolds),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          "(${snapshot.data![index].pack_size.toString()}Gm)"),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 25),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                int quantity = int
                                                                    .parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString());
                                                                print("quantitys:" +
                                                                    quantity
                                                                        .toString());

                                                                double
                                                                    quantitydata =
                                                                    double.parse(
                                                                        quantity
                                                                            .toString());
                                                                var price = snapshot
                                                                    .data![
                                                                        index]
                                                                    .productprice;
                                                                double prices =
                                                                    double.parse(
                                                                        price!);
                                                                print("prices:" +
                                                                    prices
                                                                        .toString());
                                                                quantitydata--;
                                                                print("quantitydata:" +
                                                                    quantitydata
                                                                        .toString());
                                                                //

                                                                double
                                                                    totatamounts =
                                                                    quantitydata *
                                                                        prices;
                                                                print("totalamounts:" +
                                                                    totatamounts
                                                                        .toString());

                                                                String
                                                                    totalamountsdata =
                                                                    totatamounts
                                                                        .toString();
                                                                print("totalamountsdatas:" +
                                                                    totalamountsdata
                                                                        .toString());

                                                                //convert any data type use toint and todouble etc
                                                                int quantitydatas =
                                                                    quantitydata
                                                                        .toInt();
                                                                print("quantitydatas:" +
                                                                    quantitydatas
                                                                        .toString());

                                                                if (quantitydatas >
                                                                    0) {
                                                                  dbhelper
                                                                      .updateCartdata(Cart(
                                                                          id: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id,
                                                                          productid: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productid,
                                                                          productname: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productname,
                                                                          productimage: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productimage,
                                                                          productprice: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .productprice
                                                                              .toString(),
                                                                          finaltotalprice:
                                                                              totalamountsdata,
                                                                          quantity:
                                                                              quantitydatas,
                                                                          pack_size: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .pack_size,
                                                                          userid: snapshot
                                                                              .data![
                                                                                  index]
                                                                              .userid))
                                                                      .then(
                                                                          (value) {
                                                                    totatamounts =
                                                                        0;
                                                                    quantitydatas =
                                                                        0;
                                                                    carts.removetotalprice(double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .productprice
                                                                        .toString()));
                                                                    // quantity=0;
                                                                    print(
                                                                        "updates");
                                                                    // carts.removetotalprice(double.parse(totalamountsdata.toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    debugPrint(error
                                                                        .toString());
                                                                  });
                                                                } else {}
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                  ),
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/minus.png",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            20,
                                                                      )),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 25,
                                                              width: 40,
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 3),
                                                                    child: Text(
                                                                        "${snapshot.data![index].quantity}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                Poppinsmediums)),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 6,
                                                                        right:
                                                                            6),
                                                                    // child: Divider(
                                                                    //   height: 1,
                                                                    //   color: Colors.black,
                                                                    // ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                int quantity = int
                                                                    .parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString());
                                                                print("quantitys:" +
                                                                    quantity
                                                                        .toString());

                                                                double
                                                                    quantitydata =
                                                                    double.parse(
                                                                        quantity
                                                                            .toString());
                                                                var price = snapshot
                                                                    .data![
                                                                        index]
                                                                    .productprice;
                                                                double prices =
                                                                    double.parse(
                                                                        price!);
                                                                print("prices:" +
                                                                    prices
                                                                        .toString());
                                                                quantitydata++;
                                                                print("quantitydata:" +
                                                                    quantitydata
                                                                        .toString());
                                                                //

                                                                double
                                                                    totatamounts =
                                                                    quantitydata *
                                                                        prices;
                                                                print("totalamounts:" +
                                                                    totatamounts
                                                                        .toString());

                                                                String
                                                                    totalamountsdata =
                                                                    totatamounts
                                                                        .toString();
                                                                print("totalamountsdatas:" +
                                                                    totalamountsdata
                                                                        .toString());

                                                                //convert any data type use toint and todouble etc
                                                                int quantitydatas =
                                                                    quantitydata
                                                                        .toInt();
                                                                print("quantitydatas:" +
                                                                    quantitydatas
                                                                        .toString());

                                                                dbhelper
                                                                    .updateCartdata(Cart(
                                                                        id: snapshot
                                                                            .data![
                                                                                index]
                                                                            .id,
                                                                        productid: snapshot
                                                                            .data![
                                                                                index]
                                                                            .productid,
                                                                        productname: snapshot
                                                                            .data![
                                                                                index]
                                                                            .productname,
                                                                        productimage: snapshot
                                                                            .data![
                                                                                index]
                                                                            .productimage,
                                                                        productprice: snapshot
                                                                            .data![
                                                                                index]
                                                                            .productprice
                                                                            .toString(),
                                                                        finaltotalprice:
                                                                            totalamountsdata,
                                                                        quantity:
                                                                            quantitydatas,
                                                                        pack_size: snapshot
                                                                            .data![
                                                                                index]
                                                                            .pack_size,
                                                                        userid: snapshot
                                                                            .data![
                                                                                index]
                                                                            .userid))
                                                                    .then(
                                                                        (value) {
                                                                  totatamounts =
                                                                      0;
                                                                  quantitydatas =
                                                                      0;
                                                                  carts.addtotalprice(double.parse(snapshot
                                                                      .data![
                                                                          index]
                                                                      .productprice
                                                                      .toString()));
                                                                  // quantity=0;
                                                                  print(
                                                                      "updates");
                                                                  // carts.removetotalprice(double.parse(totalamountsdata.toString()));
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  debugPrint(error
                                                                      .toString());
                                                                });
                                                              },
                                                              child: Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                  ),
                                                                  child: Icon(
                                                                      Icons
                                                                          .add)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: 110,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        int? id = snapshot
                                                            .data![index].id;
                                                        dbhelper
                                                            .deletecartdata(id!)
                                                            .then((value) {
                                                          carts.removecounter();
                                                          carts.removetotalprice(
                                                              double.parse(snapshot
                                                                  .data![index]
                                                                  .productprice
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print("error:" +
                                                              error.toString());
                                                        });
                                                      },
                                                      child: Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Image.asset(
                                                              "assets/images/exit.png",
                                                              height: 22,
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Price :₹ ${snapshot.data![index].productprice}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              Poppinsmediums,
                                                          color: Colors.black,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Total :₹ ${snapshot.data![index].finaltotalprice.toString()}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              Poppinsmediums,
                                                          color: Colors.black,
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }));
                  }
                  return Text("samad");
                },
              ),
              Consumer<Cartviewmodel>(builder: (context, value, child) {
                // return Visibility(
                //   //visibility gone karne ka code
                //   visible: value.gettotalprice().toStringAsFixed(2) == "0.00"
                //       ? false
                //       : true,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                //     child: Column(
                //       children: [
                //         Reusablewidget(
                //             title: "Sub Total:",
                //             value: r"$" +
                //                 value.gettotalprice().toStringAsFixed(2)),
                //         Reusablewidget(title: "Discount:", value: r"$" + "100"),
                //         Reusablewidget(
                //             title: "Total:",
                //             value: r"$" +
                //                 value.gettotalprice().toStringAsFixed(2)),
                //       ],
                //     ),
                //   ),
                // );
                return Visibility(
                  visible: value.gettotalprice().toStringAsFixed(2) == "0.00"
                      ? true
                      : true,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: Container(
                      color: Colors.white,
                      height: 80,
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              child: Container(
                                height: 80,
                                width: 130,
                                child: Row(
                                  children: [
                                    Reusablewidget(
                                        title: "Total",
                                        value: "${value.gettotalprice()}"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 150,
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {

                                      String username = '';
                                      String email = '';
                                      String contact_no = '';
                                      String address = '';

                                      SharedPreferences shared =
                                          await SharedPreferences.getInstance();
                                      username =
                                          (shared.getString("user_name") ?? '');
                                      email = (shared.getString("email") ?? '');
                                      contact_no =
                                          (shared.getString("contact_no") ??
                                              '');
                                      address = (shared.getString("address") ?? '');

                                      print("username:${username}${email}${contact_no}${address}");

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Billpage_Screens(
                                        username,
                                        address,
                                        contact_no,
                                        email,
                                      )));
                                    },
                                    child: Text("CHECKOUT"),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(150, 50)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}

class Reusablewidget extends StatelessWidget {
  final String title, value;

  const Reusablewidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: TextStyle(fontSize: 17, fontFamily: PoppinssemiBolds),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            value.toString(),
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Appcolors.appprimarycolor),
          ),
        ],
      ),
    );
  }
}
