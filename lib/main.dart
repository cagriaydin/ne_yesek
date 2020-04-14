import 'package:flutter/material.dart';
import 'package:ne_yesek/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NeYesek",
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Home(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
