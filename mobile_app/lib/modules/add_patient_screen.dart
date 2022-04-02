import 'package:flutter/material.dart';
import 'package:mobile_app/shared/components/components.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270.0),
        child: AppBar(
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
        child: Column(children: [
          defulttext(
            textName: 'Add patient',
            fontWeight: FontWeight.bold,
            size: 22,
          ),
        ]),
      ),
    );
  }
}
