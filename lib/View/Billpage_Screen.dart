import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Model/Cart.dart';
import 'package:indianavy_with_mvvmrestapi/OfflineDb/cartlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Model/Orderlist.dart';
import '../Model_view_Model/Cart_view_Model.dart';
import '../Model_view_Model/Orderview_Model.dart';
import '../OfflineDb/Orderlistdb.dart';
import 'Billpage_Screen.dart';
import 'Billpage_Screen.dart';

class Billpage_Screen extends StatelessWidget {
  const Billpage_Screen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Billpage_Screens extends StatefulWidget {
  // final Data task;
  var customername, customeraddress, contactno, emailaddress;

  Billpage_Screens(this.customername, this.customeraddress, this.contactno,
      this.emailaddress);

  @override
  State<Billpage_Screens> createState() => _Billpage_Screens();
}

class _Billpage_Screens extends State<Billpage_Screens> {
  Razorpay? _razorpay;
  Orderdbhelper db = Orderdbhelper();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  bool showspinnner = false;
  var data;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    // Queue<String> productname;
    Queue<String> username;

    var Cartviewmodepd = Provider.of<Cartviewmodel>(context);
    var orderlistpd = Provider.of<Orderviewmodel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/indiannavilogo.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              "${widget.customeraddress}",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Poppinsmedium'),
                            ),
                          ),
                        ),
                        Text(
                          "GST:  78GSSDR698548",
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Poppinsmedium'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Order No:",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontFamily: 'Poppinsmedium',
                    //       fontWeight: FontWeight.bold),
                    // ),

                    Consumer<Orderviewmodel>(
                      builder: (context, value, child) {
                        return Text(
                          "Order Number:${value.getordernumber()}",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppinsmedium',
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    Text(
                      "Customer Name: ${widget.customername}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Customer Adress: ${widget.customeraddress}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 3,
                color: Colors.black12,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sr.\nNo.",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Product",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "QTY",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rate",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppinsmedium',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 3,
                color: Colors.black12,
                thickness: 2,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    //set the heing to size box then
                    // fixed height
                    height: 300,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder(
                              future: Cartviewmodepd.getdata(),
                              builder: (context,
                                  AsyncSnapshot<List<Cart>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isEmpty) {
                                    return Center(
                                      // child:Text("Card is empty"),
                                      child: Container(
                                        child: Image.asset(
                                            "assets/images/cartempty.png"),
                                      ),
                                    );
                                  }
                                  return Expanded(
                                      child: ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            int indexdata =
                                                int.parse(index.toString());

                                            int cartid = indexdata;

                                            //  username=new Queue();
                                            // username.add(snapshot.data![index].id.toString());

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 30,
                                                    child: Text(
                                                      indexdata.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Poppinsmedium'),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .productname,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Poppinsmedium'),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 40,
                                                    child: Text(
                                                      snapshot
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Poppinsmedium'),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .productprice
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Poppinsmedium'),
                                                    ),
                                                  ),

                                                  // Text(student['previousproductprice'], style: TextStyle(fontSize: 16, fontFamily: 'Poppinsmedium', fontWeight: FontWeight.bold),),
                                                  Text(
                                                    snapshot.data![index]
                                                        .finaltotalprice
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Poppinsmedium'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }));
                                }
                                return Text("samad");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 3,
                color: Colors.black12,
                thickness: 2,
              ),
              Consumer<Cartviewmodel>(builder: (context, value, child) {
                return Visibility(
                  //visibility gone karne ka code
                  // visible: value.gettotalprice().toStringAsFixed(2) == "0.00"
                  //     ? false
                  //     : true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Reusablewidgetbillpage(
                              title: "Sub Total:",
                              value: r"₹" +
                                  value.gettotalprice().toStringAsFixed(2)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Reusablewidgetbillpage(
                              title: "Discount:", value: r"₹" + "0"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Reusablewidgetbillpage(
                              title: "Total Amount:",
                              value: r"₹" +
                                  value.gettotalprice().toString()),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 55,
                  width: 370,
                  child: ElevatedButton(
                      onPressed: () {

                        orderlistpd.setordernumber();
                        // db.insertorderdata(Orderlist(
                        //     cartid: cartid,
                        //     order_number: order_number,
                        //     customer_name: customer_name,
                        //     customer_address: customer_address,
                        //     Sub_total: Sub_total,
                        //     total_amount: total_amount,
                        //     product_name: product_name,
                        //     status: status,
                        //     Deliverytime: Deliverytime,
                        //     qty: qty,
                        //     Rate: Rate,
                        //     Total: Total))
                      },
                      child: Text("CONTINUE")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Reusablewidgetbillpage extends StatelessWidget {
  final String title, value;

  const Reusablewidgetbillpage({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toString(),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          value.toString(),
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ],
    );
  }
}
