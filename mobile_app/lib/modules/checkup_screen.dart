import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/bloc/patient_data/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

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
  var formKey = GlobalKey<FormState>();
  var patientIdController = TextEditingController();
  var doctorIdController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppPatientCubit, GetPatientStates>(
      listener: (context, state) {
        if (state is AppCreateCheckUpSuccessStates) {
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
            msg: "Id is not Correct",
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        textName: 'Patient id',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 135,
                      ),
                      defulttext(
                        textName: 'Doctor Id',
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
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: textFormField(
                                hint: 'Patient Id',
                                onChange: (value) {
                                  value = null;
                                },
                                keyboardType: TextInputType.number,
                                controller: patientIdController,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'field must not be empty';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: textFormField(
                                hint: 'Doctor Id',
                                onChange: (value) {
                                  value = null;
                                },
                                keyboardType: TextInputType.number,
                                controller: doctorIdController,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'field must not be empty';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: textFormField(
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
                    ConditionalBuilder(
                      condition: state is! AppCreateCheckUpLoadingStates,
                      builder: (context) => defultButton(
                        width: double.infinity,
                        changeColor: btnsColor,
                        changeText: 'Create Check Up',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            cubit.createCheckUp(
                              patientId: patientIdController.text,
                              doctorId: doctorIdController.text,
                              description: descriptionController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) => Center(
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
