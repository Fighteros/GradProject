import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/components/components.dart';

class CheckUpScreen extends StatefulWidget {
  const CheckUpScreen({Key? key}) : super(key: key);

  @override
  State<CheckUpScreen> createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<CheckUpScreen> {
  String? drugsvalue;
  String? patientvalue;
  final ImagePicker _picker = ImagePicker();
  late PickedFile _imageFile;
  // List of items in our dropdown menu
  var drugName = [
    'Insulin',
    'Anticoagulants',
    'Cholesterol absorp',
    'Aspirin',
    'Alpha-glucosidase',
    'Alpha-glucosidase',
  ];
  List<String> patientName = [
    'mohamed mostafa',
    'fathi yasser',
    'Ahmed abd-Elghany',
    'Marian Fritsch',
    'Hadeer Yousef',
  ];
  @override
  Widget build(BuildContext context) {
    // var cubit = AppPatientCubit.get(context);
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
            actions: [
              ProfileIcon(context),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              defulttext(
                textName: 'Add Checkup',
                fontWeight: FontWeight.bold,
                size: 22,
              ),
              const SizedBox(
                height: 70,
              ),
              Row(children: [
                defulttext(
                  textName: 'meds',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
                const SizedBox(
                  width: 135,
                ),
                defulttext(
                  textName: 'patient',
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: DropdownButtonFormField(
                        hint: const Text('drugs name'),
                        value: drugsvalue,
                        onChanged: (String? value) {
                          setState(() {
                            drugsvalue = value;
                          });
                        },
                        items: drugName.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        isDense: true,
                        alignment: Alignment.center,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: DropdownButtonFormField(
                        hint: const Text('patient name'),
                        value: patientvalue,
                        onChanged: (String? value) {
                          setState(() {
                            patientvalue = value;
                          });
                        },
                        items: patientName.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),

                        alignment: Alignment.center,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onTap: () {},
                decoration: const InputDecoration(
                  hintText: 'Upload File',
                ),
              ),
            ]),
          ),
        ));
  }
}
