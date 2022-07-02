import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/modules/doctor_home_screen.dart';
import 'package:mobile_app/modules/patient_screen.dart';
import 'package:mobile_app/shared/bloc/login_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/login_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, DoctorLoginStates>(
        listener: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          userlevel = cubit.login?.user!.userLevelId!.toInt();
          print(state);
          if (state is AppLoginSuccessStates) {
            CacheHelper.saveData(key: 'id', value: cubit.login?.user!.id)
                .then((value) {});
            CacheHelper.saveData(
                    key: 'userLevelId',
                    value: state.loginModel.user?.userLevelId)
                .then((value) {
              switch (userlevel) {
                case 3:
                  navigatePushAndRemove(context, HomePatientScreen());
                  break;
                case 2:
                  navigatePushAndRemove(context, DoctorScreen());
                  break;
              }
            });

            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.accessToken)
                .then((value) {
              token = cubit.login?.accessToken;
              Fluttertoast.showToast(
                msg: "You are welcome ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            });
          } else if (state is AppLoginErrorStates) {
            Fluttertoast.showToast(
              msg: "Email is not valid ",
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
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: formKey,
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
                          height: 60,
                          width: 299,
                          child: textFormField(
                              keyboardType: TextInputType.emailAddress,
                              radius: 13,
                              lable: 'username',
                              controller: userNameController,
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
                          height: 60,
                          width: 299,
                          child: textFormField(
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              radius: 13,
                              lable: 'password',
                              controller: passwordController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'password must not be empty';
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        // Container(
                        //   alignment: Alignment.bottomRight,
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: const Text('forgot password?'),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! AppLoginLoadingStates,
                            builder: (context) => defultButton(
                              changeText: 'Sign In',
                              changeColor: btnsColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 84,
                              width: 301,
                              radius: 13,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  cubit.doctorLogin(
                                    username: userNameController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => Center(
                                child: CircularProgressIndicator(
                              color: pinkColor,
                            )),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
