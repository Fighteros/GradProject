import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/modules/add_patient_screen.dart';
import 'package:mobile_app/modules/checkup_screen.dart';
import 'package:mobile_app/modules/profile_screen.dart';
import 'package:mobile_app/modules/search_screen.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/states.dart';
import 'package:mobile_app/shared/bloc/profile/cubit.dart';
import 'package:mobile_app/shared/components/components.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  String? nameOfDoctor = '';
  String? urlImage = '';
  int? checkUpLength = 0;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var docCubit = AppDoctorCubit.get(context);
    if (getDoctor != null) {
      docCubit.getDoctorData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDoctorCubit, GetDoctorStates>(
      listener: (context, state) {
        var doc = AppDoctorCubit.get(context);
        var checks = AppDoctorCubit.get(context).getCheckUp;
      },
      builder: (context, state) {
        var checks = AppDoctorCubit.get(context).getCheckUp;
        var doc = AppDoctorCubit.get(context);
        var prof = AppDoctorProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: buildPopMenuButton(context),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 13, top: 7),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        navigateTo(context, ProfileScreen());
                      },
                      icon: ConditionalBuilder(
                        condition: getDoctor != null,
                        builder: (context) => CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: image == null
                              ? NetworkImage('${getDoctor?.image?.url}')
                              : NetworkImage(
                                  '${prof.uploadImages?.image?.url}'),
                        ),
                        fallback: (context) =>
                            CircularProgressIndicator(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Hello,  Dr/ ',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      ConditionalBuilder(
                        condition: getDoctor != null,
                        builder: (context) => Text(
                          '${getDoctor?.firstName}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        fallback: (context) => Center(
                            child: CircularProgressIndicator(
                          color: Colors.grey[500],
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defulttext(
                          textName: 'Search',
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateTo(context, const SearchScreen());
                          },
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'What do you need?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                navigateTo(context, const CheckUpScreen());
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 107,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                // ignore: dead_code
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Column(
                                  children: const [
                                    FaIcon(FontAwesomeIcons.stethoscope,
                                        size: 44),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add Checkup',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                navigateTo(context, const AddPatientScreen());
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 107,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.person,
                                    size: 44,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Add Patient',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defulttext(
                    textName: 'Medical checkups',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defulttext(
                    textName: '${checks.length} checkups',
                    size: 18,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  patientBuilder(checks, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
