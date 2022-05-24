import 'package:flutter/material.dart';
import 'package:mobile_app/modules/admin/create_admin/create.dart';
import 'package:mobile_app/modules/admin/create_admin/delete.dart';
import 'package:mobile_app/modules/admin/create_admin/updata.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class CreateAdminScreen extends StatelessWidget {
  const CreateAdminScreen({Key? key}) : super(key: key);

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
            Row(
              children: [
                defultButton(
                  height: 100,
                  changeColor: btnsColor,
                  changeText: 'Create Admin',
                  onPressed: () {
                    navigateTo(context, const CreateAdmin());
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                defultButton(
                  height: 100,
                  changeColor: btnsColor,
                  changeText: 'Delete Admin',
                  onPressed: () {
                    navigateTo(context, DeleteAdmin());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            defultButton(
              height: 100,
              changeColor: btnsColor,
              changeText: 'Updata Admin',
              onPressed: () {
                navigateTo(context, UpdateAdmin());
              },
            ),
          ],
        ),
      ),
    );
  }
}
