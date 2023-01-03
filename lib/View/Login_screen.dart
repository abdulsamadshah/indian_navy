import 'package:flutter/material.dart';
import 'package:indianavy_with_mvvmrestapi/Resources/colors.dart';

import '../Model_view_Model/Auth_view_model.dart';
import '../Resources/fonts.dart';
import 'package:provider/provider.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<Authviewmodel>(context);
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: height * 0.2,
                      child: Image.asset("assets/images/indiannavilogo.png"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: TextField(
                      controller: emailid,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password",
                        style: TextStyle(fontFamily: Poppinsmediums),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 3.0,
                  ),
                  Container(
                      height: height / 14.8, //half of the height size
                      width: width / 1, //half of the width size

                      color: Appcolors.appprimarycolor,
                      child: TextButton(
                          onPressed: () {
                            Map authparam = {
                              'user_id': emailid.text,
                              'password': password.text
                            };
                            authprovider.generateMd5(password.text);

                            authprovider.loginauthenticate(context, authparam,
                                emailid.text, password.text);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: Poppinsmediums,
                                fontSize: 18),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
