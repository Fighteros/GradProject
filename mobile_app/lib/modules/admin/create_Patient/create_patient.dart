import 'package:flutter/material.dart';
import 'package:mobile_app/modules/admin/create_Patient/create.dart';
import 'package:mobile_app/modules/admin/create_Patient/delete.dart';
import 'package:mobile_app/modules/admin/create_Patient/updata.dart';
import 'package:mobile_app/modules/search_screen.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class CreatePatientScreen extends StatelessWidget {
  const CreatePatientScreen({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    defultButton(
                      height: 100,
                      changeColor: btnsColor,
                      changeText: 'Create Patient',
                      onPressed: () {
                        navigateTo(context, const CreatePatient());
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    defultButton(
                      height: 100,
                      changeColor: btnsColor,
                      changeText: 'Delete Patient',
                      onPressed: () {
                        navigateTo(context, DeletePatient());
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
                  changeText: 'Updata Patient',
                  onPressed: () {
                    navigateTo(context, UpdatePatient());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
