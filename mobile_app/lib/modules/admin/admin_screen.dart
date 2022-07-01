import 'package:flutter/material.dart';
import 'package:mobile_app/modules/admin/Create_analysis_rays/create_analysis_rays.dart';
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
          flexibleSpace: const Center(),
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
                  const CreateAdminScreen(),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Doctor',
              onPressed: () {
                navigateTo(context, const CreateDoctorScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Patient',
              onPressed: () {
                navigateTo(context, const CreatePatientScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Drugs',
              onPressed: () {
                navigateTo(context, const CreateDrugsScreen());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Analysis and Rays',
              onPressed: () {
                navigateTo(context, const CreateAnalysisScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
