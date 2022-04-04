// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app/layout/home_screen.dart';
import 'package:mobile_app/modules/add_patient_screen.dart';
import 'package:mobile_app/modules/doctor_home_screen.dart';
import 'package:mobile_app/shared/styles/themes.dart';

void main() {
  runApp(App());
}

// clear now
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes(),
      debugShowCheckedModeBanner: false,
      home: AddPatientScreen(),
    );
  }
}
