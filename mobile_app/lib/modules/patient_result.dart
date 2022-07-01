import 'package:flutter/material.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class PatientResult extends StatelessWidget {
  const PatientResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: buildPopMenuButton(context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
