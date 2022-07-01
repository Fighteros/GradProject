import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/admin_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';
import 'package:http/http.dart' as http;

class DeleteAdmin extends StatefulWidget {
  const DeleteAdmin({Key? key}) : super(key: key);

  @override
  State<DeleteAdmin> createState() => _DeleteAdminState();
}

class _DeleteAdminState extends State<DeleteAdmin> {
  var formKey = GlobalKey<FormState>();
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAdminCubit, CreateAdminStates>(
      listener: (context, state) {
        if (state is AppDeleteAdminSuccessStates) {
          Fluttertoast.showToast(
            msg: "Email is Delete",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppDeleteAdminErrorStates) {
          Fluttertoast.showToast(
            msg: "there's no admin with this id ${adminValue}",
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
                        textName: 'Delete Admin',
                        fontWeight: FontWeight.bold,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value != null &&
                                  adminValue.toString() == '1') {
                                return 'This admin Can\'t Deleted it';
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
                                      item['id'],
                                ),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                adminValue = newVal as String;
                              });
                            },
                            isDense: true,
                            value: adminValue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppDeleteAdminLoadingStates,
                          builder: (context) => defultButton(
                              changeColor: btnsColor,
                              fontWeight: FontWeight.bold,
                              radius: 13,
                              height: 40,
                              width: 130,
                              changeText: 'Delete',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  cubit.deleteAdmin(
                                    deleteID: adminValue.toString(),
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
