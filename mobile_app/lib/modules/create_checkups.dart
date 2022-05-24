import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/modules/create_drugs.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class CheckUpScreen extends StatefulWidget {
  const CheckUpScreen({Key? key}) : super(key: key);

  @override
  State<CheckUpScreen> createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<CheckUpScreen> {
  String? patientvalue;
  final ImagePicker _picker = ImagePicker();
  late PickedFile _imageFile;
  List data = [];
  Future<String> getSWData() async {
    var res = await http.get(
        Uri.parse('https://grad-project-fy-1.herokuapp.com/api/v1/patients/'),
        headers: {
          "authorization": 'Bearer $token',
        });
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  void initState() {
    super.initState();
    this.getSWData();
  }

  // List of items in our dropdown menu
  var formKey = GlobalKey<FormState>();
  var patientIdController = TextEditingController();
  var doctorIdController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppPatientCubit, GetPatientStates>(
      listener: (context, state) {
        var cubit = AppPatientCubit.get(context);
        if (state is AppCreateCheckUpSuccessStates) {
          //To Sava CheckUp Id
          CacheHelper.saveData(
              key: 'idCheckUps', value: cubit.checkUpModel?.id);

          Fluttertoast.showToast(
            msg: "CheckUp Added Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppCreateCheckUpErrorStates) {
          Fluttertoast.showToast(
            msg: "ERROR",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppPatientCubit.get(context);
        var cubita = AppPatientCubit.get(context);
        var checks = AppDoctorCubit.get(context);
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
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defulttext(
                      textName: 'Add Checkup',
                      fontWeight: FontWeight.bold,
                      size: 22,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        defulttext(
                          textName: 'Patient',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: DropdownButton(
                        hint: const Text(' Select Patient'),
                        items: data.map((item) {
                          return DropdownMenuItem(
                            child: Text(' ' +
                                item['first_name'] +
                                ' ' +
                                item['last_name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            patientvalue = newVal as String;
                          });
                        },
                        value: patientvalue,
                        underline: Container(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defulttext(
                      textName: 'Description',
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: textFormField(
                          radius: 15,
                          hint: 'Description',
                          onChange: (value) {
                            value = null;
                          },
                          keyboardType: TextInputType.multiline,
                          controller: descriptionController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'field must not be empty';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ConditionalBuilder(
                      condition: state is! AppCreateCheckUpLoadingStates,
                      builder: (context) => defultButton(
                          width: double.infinity,
                          changeColor: btnsColor,
                          changeText: 'Create Check Up',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              cubit.createCheckUp(
                                patientId: patientvalue.toString(),
                                doctorId: idStart.toString(),
                                description: descriptionController.text,
                              );
                            }
                          }),
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                        color: pinkColor,
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName:
                          'Can\'t add Drugs Without Create Check Up Firstly',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    defultButton(
                        width: double.infinity,
                        changeColor: btnsColor,
                        changeText: 'Add Drugs',
                        onPressed: () {
                          navigateTo(context, const DrugsScreen());
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
