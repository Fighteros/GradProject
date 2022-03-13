// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'xHealth',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
      body: Center(
        child: Text(
          'xHealth HomeScreen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
      ),
    );
  }
}
