import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';
import 'package:http/http.dart' as http;

class UpdateAdmin extends StatefulWidget {
  const UpdateAdmin({Key? key}) : super(key: key);

  @override
  State<UpdateAdmin> createState() => _CreateState();
}

class _CreateState extends State<UpdateAdmin> {
  var formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  var fstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var jobController = TextEditingController();
  List data = [];
  String? adminValue;
  Future<String> getData() async {
    var res = await http.get(
        Uri.parse('https://grad-project-fy-1.herokuapp.com/api/v1/admins/'),
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
    this.getData();
    var cubit = AppAdminCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAdminCubit, CreateAdminStates>(
      listener: (context, state) {
        var cubit = AppAdminCubit.get(context);
        if (state is AppUpdateAdminSuccessStates) {
          Fluttertoast.showToast(
            msg: "Email is Update",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppUpdateAdminErrorStates) {
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
        fstNameController.text = "${cubit.adminModel?.firstName}";
        lastNameController.text = "${cubit.adminModel?.lastName}";
        emailController.text = "${cubit.adminModel?.email}";
        phoneController.text = "${cubit.adminModel?.phoneNumber}";
        ageController.text = "${cubit.adminModel?.age}";
        genderController.text = "${cubit.adminModel?.gender}";
        jobController.text = "${cubit.adminModel?.jobTitle}";
      },
      builder: (context, state) {
        var cubit = AppAdminCubit.get(context);
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
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defulttext(
                        textName: 'Update Admin',
                        fontWeight: FontWeight.bold,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defulttext(
                        textName: 'Id Admin',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null && adminValue.toString() == '1') {
                              return 'field must not be empty';
                            }
                            return null;
                          },
                          hint: const Text(' Select Admin'),
                          items: data.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                ' ' +
                                    item['first_name'] +
                                    ' ' +
                                    item['last_name'] +
                                    '  ' +
                                    'Id: ' +
                                    item['id'].toString(),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              adminValue = newVal as String;
                            });
                          },
                          value: adminValue,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppGetAdminLoadingStates,
                          builder: (context) => defultButton(
                              changeColor: btnsColor,
                              fontWeight: FontWeight.bold,
                              radius: 13,
                              height: 40,
                              width: 130,
                              changeText: 'Get Info',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  cubit.getAdminData(
                                    getAdminID: adminValue.toString(),
                                  );
                                }
                              }),
                          fallback: (context) => Center(
                              child:
                                  CircularProgressIndicator(color: pinkColor)),
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
                        textName: 'job Tilte',
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
                        hint: 'job Tilte',
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
                          condition: state is! AppUpdateAdminLoadingStates,
                          builder: (context) => defultButton(
                              changeColor: btnsColor,
                              fontWeight: FontWeight.bold,
                              radius: 13,
                              height: 40,
                              width: 130,
                              changeText: 'UpDate',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                cubit.upDateAdmin(
                                  upDateID: adminValue.toString(),
                                  firstName: fstNameController.text,
                                  age: ageController.text,
                                  gender: genderController.text,
                                  lastName: lastNameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  jobTitle: jobController.text,
                                );
                              }),
                          fallback: (context) => Center(
                              child:
                                  CircularProgressIndicator(color: pinkColor)),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
