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

class UpdateDrugs extends StatefulWidget {
  const UpdateDrugs({Key? key}) : super(key: key);

  @override
  State<UpdateDrugs> createState() => _CreateState();
}

class _CreateState extends State<UpdateDrugs> {
  var formKey = GlobalKey<FormState>();
  var drugNameController = TextEditingController();
  List data = [];
  String? drugsValue;
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

  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAdminCubit, CreateAdminStates>(
      listener: (context, state) {
        var cubit = AppAdminCubit.get(context);
        if (state is AppUpdateDrugsSuccessStates) {
          Fluttertoast.showToast(
            msg: "Drugs is Update",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppUpdateDrugsErrorStates) {
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
        drugNameController.text = '${cubit.getdrugs?.drugName}';
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
                        textName: 'Update Drugs',
                        fontWeight: FontWeight.bold,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defulttext(
                        textName: 'Id Drugs',
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
                            if (value == null) {
                              return 'field must not be empty';
                            }
                            return null;
                          },
                          hint: const Text(' Select Drugs'),
                          items: data.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                ' ' +
                                    item['drug_name'] +
                                    '  ' +
                                    'Id: ' +
                                    item['id'].toString(),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              drugsValue = newVal as String;
                            });
                          },
                          value: drugsValue,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppGetDrugsLoadingStates,
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
                                  cubit.getDrugsData(
                                    getDrugsID: drugsValue.toString(),
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
                        textName: 'Drug',
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
                        validate: (String? value) {
                          value != null;
                        },
                        onChange: (value) {
                          value = null;
                        },
                        controller: drugNameController,
                        hint: 'Drugs',
                        radius: 20,
                        hintStyle: const TextStyle(
                          fontSize: 13,
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppUpdateDrugsLoadingStates,
                          builder: (context) => defultButton(
                              changeColor: btnsColor,
                              fontWeight: FontWeight.bold,
                              radius: 13,
                              height: 40,
                              width: 130,
                              changeText: 'UpDate',
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  cubit.upDateDrugs(
                                    upDateID: drugsValue.toString(),
                                    name: drugNameController.text,
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
