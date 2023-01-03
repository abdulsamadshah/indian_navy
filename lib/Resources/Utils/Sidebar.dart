import 'package:flutter/material.dart';

import '../fonts.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                child: Image.asset(
                  "assets/images/indiannavilogo.png"
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: 20,
              ),


                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Counter Order",style: TextStyle(color: Colors.grey,fontFamily: PoppinssemiBolds),),
                  ),

              listitem(title: "Take Order", icon: Icons.note_alt_rounded, ontap: (){}),
              listitem(title: "Order List", icon: Icons.note_alt_rounded, ontap: (){}),
            ],
          )
        ],
      )),
    );
  }
}

Widget listitem(
    {required String title,
    required IconData icon,
    required VoidCallback ontap}) {
  final color = Colors.black87;
  final hovercolor = Colors.black87;

  return GestureDetector(
    onTap: ontap,
    child: ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      hoverColor: hovercolor,
      title: Text(title, style: TextStyle(color: color)),
    ),
  );
}
