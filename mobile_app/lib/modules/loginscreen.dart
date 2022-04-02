// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/modules/doctor_home_screen.dart';
import 'package:mobile_app/shared/bloc/cubit.dart';
import 'package:mobile_app/shared/bloc/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, AppLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Center(
                        child: Text(
                          'Welcome, Onboard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Let\'s help you get in',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 49.35,
                        width: 299,
                        child: textFormField(
                            keyboardType: TextInputType.emailAddress,
                            radius: 13,
                            lable: 'username',
                            controller: userNameController,
                            onTap: () {
                              userNameController.text;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'username must not be empty';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: 49.35,
                        width: 299,
                        child: textFormField(
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            radius: 13,
                            lable: 'password',
                            controller: passwordController,
                            onTap: () {
                              passwordController.text;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('forgot password?'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: defultButton(
                          changeText: 'Sign In',
                          changeColor: btnsColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 84,
                          width: 301,
                          radius: 13,
                          onPressed: () {
                            navigateTo(
                              context,
                              const DoctorScreen(),
                            );
                          },
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
