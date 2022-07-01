import 'package:flutter/material.dart';
import 'package:mobile_app/modules/admin/Create_analysis_rays/create.dart';
import 'package:mobile_app/modules/admin/Create_analysis_rays/delete.dart';
import 'package:mobile_app/modules/admin/Create_analysis_rays/updata.dart';
import 'package:mobile_app/modules/admin/Create_drugs/delete.dart';
import 'package:mobile_app/modules/admin/Create_drugs/updata.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class CreateAnalysisScreen extends StatelessWidget {
  const CreateAnalysisScreen({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                defultButton(
                  height: 100,
                  changeColor: btnsColor,
                  changeText: 'Create Analysis',
                  onPressed: () {
                    navigateTo(context, const CreateAnalysis());
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                defultButton(
                  height: 100,
                  changeColor: btnsColor,
                  changeText: 'Delete Analysis',
                  onPressed: () {
                    navigateTo(context, DeleteAnalysis());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            defultButton(
              height: 100,
              width: 190,
              changeColor: btnsColor,
              changeText: 'Updata Analysis',
              onPressed: () {
                navigateTo(context, UpdateAnalysis());
              },
            ),
          ],
        ),
      ),
    );
  }
}
