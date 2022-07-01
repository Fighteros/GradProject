import 'dart:convert';
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/cubit.dart';
import 'package:mobile_app/shared/bloc/patient_data/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<AnalysisScreen> {
  String? analysisvalueId;
  bool buttomSheet = false;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  String filePath = "";
  final ImagePicker _picker = ImagePicker();
  late PickedFile _imageFile;
  List data = [];
  List checkUpdata = [];

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

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppPatientCubit, GetPatientStates>(
      listener: (context, state) {
        if (state is AppUpoaldAnalysisSuccessStates) {
          Fluttertoast.showToast(
            msg: "Image Uploaded",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is AppUpoaldAnalysisErrorStates) {
          Fluttertoast.showToast(
            msg: "Image does not upload",
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
        var cubit = AppPatientCubit.get(context);
        return Scaffold(
          key: scaffoldkey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(270.0),
            child: AppBar(
              elevation: 0.0,
              flexibleSpace: Center(
                child: Container(
                  height: 188,
                  width: 217,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/lime-treatment-by-doctor.png'),
                    ),
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(0),
                ),
              ),
              leading: buildPopMenuButton(context),
              actions: [
                ProfileIcon(context),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defulttext(
                      textName: 'Upload Analysis',
                      fontWeight: FontWeight.bold,
                      size: 22,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        defulttext(
                          textName: 'Analysis',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
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
                            child: Text(' ' +
                                item['name'] +
                                ' '
                                    'id: ' +
                                item['id'].toString()),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            analysisvalueId = newVal as String?;
                          });
                        },
                        value: analysisvalueId,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: imageFromGallery,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(25),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              splashColor: Colors.grey[300],
                              icon: Icon(
                                Icons.cloud_upload_sharp,
                              ),
                              onPressed: () {
                                scaffoldkey.currentState
                                    ?.showBottomSheet((context) => Container(
                                          width: double.infinity,
                                          height: 120,
                                          child: SafeArea(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                      leading: const Icon(
                                                          Icons.camera_alt),
                                                      title:
                                                          const Text('Camera'),
                                                      onTap: () {
                                                        imageFromCamera();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                  ListTile(
                                                      leading: const Icon(
                                                          Icons.image),
                                                      title:
                                                          const Text('Gallery'),
                                                      onTap: () {
                                                        imageFromGallery();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                ]),
                                          ),
                                        ));
                              },
                            ),
                            defulttext(
                              textName: 'Upload Analysis ',
                              fontWeight: FontWeight.bold,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: defultButton(
                          changeText: 'Upload',
                          changeColor: btnsColor,
                          changeColorOfText: Colors.white,
                          onPressed: () {
                            print(analysisImages!.path);
                            print(analysisvalueId.toString());
                            var idCheckUp =
                                CacheHelper.getData(key: 'idCheckUps');
                            cubit.upLoadAnalysis(
                              analysisId: analysisvalueId.toString(),
                              checkUpId: idCheckUp.toString(),
                            );
                          }),
                    ),
                    if (state is AppUpoaldAnalysisLoadingStates)
                      Center(
                        child: Container(
                          height: 4,
                          width: 145,
                          child: LinearProgressIndicator(
                            color: pinkColor,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
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
          analysisImages = File(value.path);
          filePath = value.path;
          print(filePath);
        });
      }
    }).catchError((error) {
      print("Catch Error");
      // print(error.toString());
    });
  }

  void imageFromCamera() {
    ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      print("Success pick Image From Gallery");
      if (value != null) {
        setState(() {
          analysisImages = File(value.path);
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
