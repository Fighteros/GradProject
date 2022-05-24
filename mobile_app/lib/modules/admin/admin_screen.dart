import 'package:flutter/material.dart';
import 'package:mobile_app/modules/admin/Create_drugs/create_drugs.dart';
import 'package:mobile_app/modules/admin/create_admin/create_admin.dart';
import 'package:mobile_app/modules/admin/create_doctor/create_doctor.dart';
import 'package:mobile_app/modules/admin/create_patient/create_patient.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Center(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          leading: buildPopMenuButton(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Admin',
              onPressed: () {
                navigateTo(
                  context,
                  CreateAdminScreen(),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Doctor',
              onPressed: () {
                navigateTo(context, CreateDoctorScreen());
              },
            ),
            SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Patient',
              onPressed: () {
                navigateTo(context, CreatePatientScreen());
              },
            ),
            SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Drugs',
              onPressed: () {
                navigateTo(context, CreateDrugsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
