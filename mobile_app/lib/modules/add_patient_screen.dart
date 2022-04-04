// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final text = TextEditingController();
  bool _validate = false;
  var fstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  void dispose() {
    fstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270.0),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Center(
            child: Container(
              height: 188,
              width: 217,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/lime-treatment-by-doctor.png'),
                ),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          leading: buildPopMenuButton(context),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 1, top: 7),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: Image(
                  image: AssetImage('images/covid.png'),
                  height: 40,
                  width: 200,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            defulttext(
              textName: 'Add patient',
              fontWeight: FontWeight.bold,
              size: 22,
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                defulttext(
                  textName: 'first name',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                const SizedBox(
                  width: 100,
                ),
                defulttext(
                  textName: 'last name',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 55,
                  child: textField(
                    error: _validate ? 'Value Can\'t Be Empty' : null,
                    keyboardType: TextInputType.name,
                    controller: fstNameController,
                    hint: 'first name',
                    radius: 20,
                    hintStyle: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: 150,
                  height: 55,
                  child: textField(
                    error: _validate ? 'Value Can\'t Be Empty' : null,
                    controller: lastNameController,
                    hint: 'last name',
                    radius: 20,
                    hintStyle: const TextStyle(
                      fontSize: 13,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            defulttext(
              textName: 'email',
              fontWeight: FontWeight.bold,
              size: 16,
            ),
            const SizedBox(
              height: 5,
            ),
            textField(
              error: _validate ? 'Value Can\'t Be Empty' : null,
              controller: emailController,
              hint: 'email',
              radius: 20,
              hintStyle: const TextStyle(
                fontSize: 13,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            defulttext(
              textName: 'phone number',
              fontWeight: FontWeight.bold,
              size: 16,
            ),
            const SizedBox(
              height: 5,
            ),
            textField(
              error: _validate ? 'Value Can\'t Be Empty' : null,
              controller: phoneController,
              hint: 'phone',
              radius: 20,
              hintStyle: const TextStyle(
                fontSize: 13,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: defultButton(
                  changeColor: btnsColor,
                  fontWeight: FontWeight.bold,
                  radius: 13,
                  height: 40,
                  width: 130,
                  changeText: 'add +',
                  onPressed: () {
                    setState(() {
                      if (fstNameController.text.isEmpty ||
                          fstNameController.text.contains(RegExp('[1-9]'))) {
                        _validate = true;
                      } else if (lastNameController.text.isEmpty ||
                          lastNameController.text.contains(RegExp('[1-9]'))) {
                        _validate = true;
                      } else if (emailController.text.isEmpty ||
                          !emailController.text.contains(RegExp('[1-9a-Z@]'))) {
                        _validate = true;
                      } else if (phoneController.text.isEmpty ||
                          !phoneController.text.contains(RegExp('[1-9]'))) {
                        _validate = true;
                      } else {
                        _validate = false;
                      }
                    });
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
