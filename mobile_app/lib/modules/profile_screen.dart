import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/modules/edit_profiles.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDoctorProfileCubit, GetDoctorProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppDoctorCubit.get(context);
        var profile = AppDoctorProfileCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: AppBar(
              backgroundColor: scaffoldColor,
              elevation: 0,
              leading: buildPopMenuButton(context),
              actions: [
                TextButton(
                    onPressed: () {
                      navigateTo(context, EditProfile());
                    },
                    child: const Text(
                      'edit',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: image == null
                          ? NetworkImage('${cubit.getDoctor?.image!.url}')
                          : NetworkImage('${profile.uploadImages?.image?.url}'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 20,
                  width: 290,
                  child: const Divider(
                    color: Colors.black,
                    thickness: 1.7,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${cubit.getDoctor?.firstName} ${cubit.getDoctor?.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Egypt'),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('|'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('${cubit.getDoctor?.jobTitle}'),
                  ],
                ),
                Text('${cubit.getDoctor?.age} Years'),
              ],
            ),
          ),
        );
      },
    );
  }
}
