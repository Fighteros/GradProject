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

class DeleteDrugs extends StatefulWidget {
  const DeleteDrugs({Key? key}) : super(key: key);

  @override
  State<DeleteDrugs> createState() => _DeleteAdminState();
}

class _DeleteAdminState extends State<DeleteDrugs> {
  var formKey = GlobalKey<FormState>();
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
        if (state is AppDeleteDrugsSuccessStates) {
          Fluttertoast.showToast(
            msg: "Drugs is Delete",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppDeleteDrugsErrorStates) {
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
                        textName: 'Delete Drugs',
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
                                    ' ' +
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
                      const SizedBox(height: 20),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppDeleteDrugsLoadingStates,
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
                                  cubit.deleteDrugs(
                                    deleteID: drugsValue.toString(),
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
