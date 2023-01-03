import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/Routes/RoutesName.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/Utils/Sidebar.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/Utils/Utils.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/colors.dart';
import 'package:provider/provider.dart';
import '../Model_view_Model/userviewmodel.dart';
import '../Resources/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var size, height, width;

  //sharepref
  String username = '';
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('user_name') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    var Userviewmodelprovider = Provider.of<Userviewmodel>(context);

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var datetime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.appprimarycolor,
        title: Text("India Navy"),
        elevation: 0,
      ),
      drawer: Sidebar(),
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Appcolors.appprimarycolor,
                height: height * .1,
                width: width * 1.0,
                // width: width*3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, top: 0, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 5),
                              child: Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: PoppinssemiBolds),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 0),
                              child: Text(
                                "${username}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: Poppinsmediums),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: GestureDetector(
                          onTap: ()async {

                              Userviewmodelprovider.removeuser().then((value){
                                print("logout successfully");
                                Utils.showflushbar("Logout Successfully", context);
                                Navigator.pushNamed(
                                    context, RoutesName.Login_screen);
                              }).onError((error, stackTrace){
                                print("some issue");
                              });

                          },
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: height / 7.9,
                color: Appcolors.appprimarycolor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "${datetime.hour}:${datetime.minute}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Poppinsmediums,
                              fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "${datetime.day}-${datetime.month}-${datetime.year}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: PoppinssemiBolds,
                                fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 5, bottom: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.Counterscreen);
                          },
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/cart.png",
                                      height: 60,
                                      width: 80,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Take Order",
                                        style: TextStyle(
                                            fontFamily: Poppinsbolds,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 5, bottom: 25),
                        child: Card(
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/packing_list.png",
                                    height: 60,
                                    width: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Order List",
                                      style: TextStyle(
                                          fontFamily: Poppinsbolds,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
