// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app/layout/home_screen.dart';
import 'package:mobile_app/modules/add_patient_screen.dart';
import 'package:mobile_app/modules/doctor_home_screen.dart';
import 'package:mobile_app/shared/styles/themes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes(),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: HomeScreen(),
=======
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
>>>>>>> e496e55df183be9654033112d260505ede72ea63
    );
  }
}
