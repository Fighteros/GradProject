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

class DeleteAnalysis extends StatefulWidget {
  const DeleteAnalysis({Key? key}) : super(key: key);

  @override
  State<DeleteAnalysis> createState() => _DeleteAdminState();
}

class _DeleteAdminState extends State<DeleteAnalysis> {
  var formKey = GlobalKey<FormState>();
  List data = [];
  String? analysisValue;
  Future<String> getData() async {
    var res = await http.get(
        Uri.parse('https://grad-project-fy-1.herokuapp.com/api/v1/rays/'),
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
        if (state is AppDeleteAnalysisSuccessStates) {
          Fluttertoast.showToast(
            msg: "Analysis is Delete",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppDeleteAnalysisErrorStates) {
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
                        textName: 'Delete Analysis',
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
                          hint: const Text(' Select Analysis'),
                          items: data.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                ' ' +
                                    item['name'] +
                                    ' ' +
                                    'Id: ' +
                                    item['id'].toString(),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              analysisValue = newVal as String;
                            });
                          },
                          value: analysisValue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppDeleteAnalysisLoadingStates,
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
                                  cubit.deleteAnalysis(
                                    deleteID: analysisValue.toString(),
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
