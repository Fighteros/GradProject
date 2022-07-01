import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class DrugsScreen extends StatefulWidget {
  const DrugsScreen({Key? key}) : super(key: key);

  @override
  State<DrugsScreen> createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<DrugsScreen> {
  String? drugsvalueId;
  String? checkUpvalueId;
  final ImagePicker _picker = ImagePicker();
  late PickedFile _imageFile;
  List data = [];
  List checkUpdata = [];

  Future<String> getData() async {
    var res = await http.get(
        Uri.parse('https://grad-project-fy-1.herokuapp.com/api/v1/drugs/'),
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

  Future<String> getCheckUpData() async {
    var res = await http.get(
        Uri.parse(
            'https://grad-project-fy-1.herokuapp.com/api/v1/checkups/doctor'),
        headers: {
          "authorization": 'Bearer $token',
        });
    var resBody = json.decode(res.body);
    setState(() {
      checkUpdata = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  void initState() {
    super.initState();
    this.getData();
    this.getCheckUpData();
  }

  var formKey = GlobalKey<FormState>();
  var quantityController = TextEditingController();
  var timePerDayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppPatientCubit, GetPatientStates>(
      listener: (context, state) {
        if (state is AppDrugsSuccessStates) {
          Fluttertoast.showToast(
            msg: "CheckUp Added Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppDrugsErrorStates) {
          Fluttertoast.showToast(
            msg: "a checkup with this id ($checkUpvalueId) doesn't exists",
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
                      textName: 'Add Drugs',
                      fontWeight: FontWeight.bold,
                      size: 22,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        defulttext(
                          textName: 'Drugs',
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
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'field must not be empty';
                          }
                          return null;
                        },
                        hint: const Text(' Select Drugs'),
                        items: data.map((item) {
                          return DropdownMenuItem(
                            child: Text(' ' +
                                item['drug_name'] +
                                ' '
                                    'id: ' +
                                item['id'].toString()),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            drugsvalueId = newVal as String?;
                          });
                        },
                        value: drugsvalueId,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName: 'Quantity',
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
                          hint: 'Quantity',
                          onChange: (value) {
                            value = null;
                          },
                          keyboardType: TextInputType.number,
                          controller: quantityController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'field must not be empty';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName: 'Time-per-day',
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        radius: 15,
                        hint: 'Time-per-day',
                        onChange: (value) {
                          value = null;
                        },
                        keyboardType: TextInputType.number,
                        controller: timePerDayController,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'field must not be empty';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    ConditionalBuilder(
                      condition: state is! AppDrugsLoadingStates,
                      builder: (BuildContext context) => defultButton(
                        width: double.infinity,
                        changeColor: btnsColor,
                        changeText: 'Add Drugs',
                        onPressed: () {
                          var idCheckUp =
                              CacheHelper.getData(key: 'idCheckUps');
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            cubit.createCheckUpDrugs(
                              quantity: quantityController.text,
                              timePerDay: timePerDayController.text,
                              checkUpId: idCheckUp.toString(),
                              checkUpDrugsId: drugsvalueId.toString(),
                            );
                          }
                          ;
                        },
                      ),
                      fallback: (BuildContext context) => Center(
                          child: CircularProgressIndicator(
                        color: pinkColor,
                      )),
                    ),
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
