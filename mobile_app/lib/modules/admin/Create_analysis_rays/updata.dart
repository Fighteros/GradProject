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

class UpdateAnalysis extends StatefulWidget {
  const UpdateAnalysis({Key? key}) : super(key: key);

  @override
  State<UpdateAnalysis> createState() => _CreateState();
}

class _CreateState extends State<UpdateAnalysis> {
  var formKey = GlobalKey<FormState>();
  TextEditingController analysisNameController = TextEditingController();
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
        var cubit = AppAdminCubit.get(context);
        if (state is AppUpdateAnalysisSuccessStates) {
          Fluttertoast.showToast(
            msg: "Analysis is Update",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppUpdateAnalysisErrorStates) {
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
        // analysisNameController.text = "${cubit.getanalysis?.analysis?.name}";
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
                        textName: 'Update Analysis',
                        fontWeight: FontWeight.bold,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defulttext(
                        textName: 'Id Analysis',
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
                          hint: const Text(' Select Analysis'),
                          items: data.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                ' ' +
                                    item['name'] +
                                    '  ' +
                                    'Id: ' +
                                    item['id'].toString(),
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              analysisValue = newVal as String?;
                            });
                          },
                          value: analysisValue,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! AppGetAnalysisLoadingStates,
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
                                  print(
                                      "analysis" + analysisNameController.text);
                                  cubit.getAnalysisData(
                                    getAnalysisID: analysisValue.toString(),
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
                        textName: 'Analysis',
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFormField(
                        validate: (String? value) {
                          value != null;
                        },
                        onChange: (value) {
                          value = null;
                        },
                        controller: analysisNameController,
                        hint: 'Analysis',
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
                          condition: state is! AppUpdateAnalysisLoadingStates,
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
                                  cubit.upDateAnalysis(
                                    upDateID: analysisValue.toString(),
                                    named: analysisNameController.text,
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
