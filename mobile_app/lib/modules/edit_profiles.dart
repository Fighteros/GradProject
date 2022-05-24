import 'dart:convert';
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/states.dart';
import 'package:mobile_app/shared/bloc/profile/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String filePath = "";
  var idController = TextEditingController();
  var fstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var jobController = TextEditingController();

  void initState() {
    super.initState();
    var cubit = AppDoctorCubit.get(context);
    cubit.getDoctorData(idStart);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDoctorProfileCubit, GetDoctorProfileStates>(
      listener: (context, state) {
        if (state is AppUpdatDoctorSuccessStates) {
          Fluttertoast.showToast(
            msg: "Email is Update",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppUpdatDoctorErrorStates) {
          Fluttertoast.showToast(
            msg: "there's no admin with this id${idController.text}",
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
        var cubit = AppDoctorCubit.get(context);
        fstNameController.text = "${getDoctor?.firstName}";
        lastNameController.text = "${getDoctor?.lastName}";
        emailController.text = "${getDoctor?.email}";
        phoneController.text = "${getDoctor?.phoneNumber}";
        ageController.text = "${getDoctor?.age}";
        genderController.text = "${getDoctor?.gender}";
        jobController.text = "${getDoctor?.jobTitle}";
        var profile = AppDoctorProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            elevation: 0,
            leading: buildPopMenuButton(context),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage: image == null
                                  ? NetworkImage('${getDoctor?.image?.url}')
                                  : FileImage(image!) as ImageProvider,
                            ),
                            CircleAvatar(
                              backgroundColor: scaffoldColor,
                              radius: 19.7,
                            ),
                            IconButton(
                              onPressed: () {
                                imageFromGallery();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.black54,
                                size: 30,
                              ),
                              alignment: AlignmentDirectional.bottomCenter,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defultButton(
                            changeText: 'Upload',
                            changeColor: btnsColor,
                            changeColorOfText: Colors.white,
                            onPressed: () {
                              profile.upLoadImageProfile();
                            }),
                      ],
                    ),
                    if (state is AppUploadProfileImageLoadingStates)
                      Container(
                        height: 4,
                        width: 145,
                        child: LinearProgressIndicator(
                          color: pinkColor,
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    defulttext(
                      textName: 'email',
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                      // validate: (value) {
                      //   if (value.isEmpty) {
                      //     return 'email must not be empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      validate: (value) {
                        value != null;
                      },
                      onChange: (value) {
                        value = null;
                      },
                      controller: emailController,
                      hint: 'email',
                      radius: 20,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
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
                          width: 155,
                          height: 70,
                          child: textFormField(
                            keyboardType: TextInputType.name,
                            controller: fstNameController,
                            hint: 'first name',
                            radius: 20,
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            onChange: (value) {
                              value = null;
                            },
                            validate: (value) {
                              value != null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 155,
                          height: 70,
                          child: textFormField(
                            controller: lastNameController,
                            hint: 'last name',
                            radius: 20,
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            onChange: (value) {
                              value = null;
                            },
                            keyboardType: TextInputType.name,
                            validate: (value) {
                              value != null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName: 'gender',
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                      // validate: (value) {
                      //   if (value.isEmpty) {
                      //     return 'password must not be empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      validate: (value) {
                        value != null;
                      },
                      onChange: (value) {
                        value = null;
                      },
                      controller: genderController,
                      hint: 'gender',
                      radius: 20,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName: 'job Title',
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                      // validate: (value) {
                      //   if (value.isEmpty) {
                      //     return 'password must not be empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      validate: (value) {
                        value != null;
                      },
                      onChange: (value) {
                        value = null;
                      },
                      controller: jobController,
                      hint: 'job Title',
                      radius: 20,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName: 'age',
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                      // validate: (value) {
                      //   if (value.isEmpty) {
                      //     return 'password must not be empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      validate: (value) {
                        value != null;
                      },
                      onChange: (value) {
                        value = null;
                      },
                      controller: ageController,
                      hint: 'age',
                      radius: 20,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.number,
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
                    textFormField(
                      // validate: (value) {
                      //   if (value.isEmpty) {
                      //     return 'phone must not be empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      validate: (value) {
                        value != null;
                      },
                      onChange: (value) {
                        value = null;
                      },
                      controller: phoneController,
                      hint: 'phone',
                      radius: 20,
                      hintStyle: const TextStyle(
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition: state is! AppUpdatDoctorLoadingStates,
                        builder: (context) => defultButton(
                            changeColor: btnsColor,
                            fontWeight: FontWeight.bold,
                            radius: 13,
                            height: 40,
                            width: 130,
                            changeText: 'UpDate',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              profile.updateDoctorData(
                                id: idStart.toString(),
                                firstName: fstNameController.text,
                                lastName: lastNameController.text,
                                age: ageController.text,
                                gender: genderController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                jobTitle: jobController.text,
                              );
                            }),
                        fallback: (context) => Center(
                            child: CircularProgressIndicator(color: pinkColor)),
                      ),
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

  void imageFromGallery() {
    ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      print("Success pick Image From Gallery");
      if (value != null) {
        setState(() {
          image = File(value.path);
          filePath = value.path;
          print(filePath);
        });
      }
    }).catchError((error) {
      print("Catch Error");
      // print(error.toString());
    });
  }
}
