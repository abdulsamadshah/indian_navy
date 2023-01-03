import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const searchscreen());
}

class searchscreen extends StatelessWidget {
  const searchscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Splash(),
    );
  }
}

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<Searchscreen> {
  TextEditingController controller = TextEditingController(text: "test");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Cupertino Search TextField Demo"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
      ),
      body: CupertinoPageScaffold(
        backgroundColor: Colors.grey[200],
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/logo.png",
                height: 300,
                width: 350,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: CupertinoSearchTextField(
                  controller: controller,
                  onChanged: (value) {

                  },
                  onSubmitted: (value) {

                  },
                  autocorrect: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
