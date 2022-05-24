import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor({Key? key}) : super(key: key);

  @override
  State<CreateDoctor> createState() => _CreateState();
}

class _CreateState extends State<CreateDoctor> {
  var formKey = GlobalKey<FormState>();
  var fstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAdminCubit, CreateAdminStates>(
      listener: (context, state) {
        var cubit = AppAdminCubit.get(context);
        if (state is AppCreateDoctorSuccessStates) {
          Fluttertoast.showToast(
            msg: "Email is created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppCreateDoctorErrorStates) {
          Fluttertoast.showToast(
            msg: "Couldn't create Doctor with that email",
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
                        textName: 'Create Doctor',
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
                                  if (value.isEmpty) {
                                    return 'first name must not be empty';
                                  } else {
                                    return null;
                                  }
                                }),
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
                                  if (value.isEmpty) {
                                    return 'last name must not be empty';
                                  } else {
                                    return null;
                                  }
                                }),
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
                      textFormField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          } else {
                            return null;
                          }
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
                      const SizedBox(
                        height: 10,
                      ),
                      defulttext(
                        textName: 'password',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFormField(
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'password must not be empty';
                          } else {
                            return null;
                          }
                        },
                        onChange: (value) {
                          value = null;
                        },
                        obscureText: true,
                        controller: passwordController,
                        hint: 'password',
                        radius: 20,
                        hintStyle: const TextStyle(
                          fontSize: 13,
                        ),
                        keyboardType: TextInputType.visiblePassword,
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
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          } else {
                            return null;
                          }
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
                          condition: state is! AppCreateDoctorLoadingStates,
                          builder: (context) => defultButton(
                              changeColor: btnsColor,
                              fontWeight: FontWeight.bold,
                              radius: 13,
                              height: 40,
                              width: 130,
                              changeText: 'add +',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  cubit.createDoctor(
                                    firstName: fstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
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
