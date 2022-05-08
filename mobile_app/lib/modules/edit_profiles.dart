import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String filePath = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDoctorProfileCubit, GetDoctorProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppDoctorCubit.get(context);
        var profile = AppDoctorProfileCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: scaffoldColor,
            elevation: 0,
            leading: buildPopMenuButton(context),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
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
                          ? NetworkImage('${getDoctor?.image?.url}')
                          : FileImage(image!) as ImageProvider,
                    ),
                    CircleAvatar(
                      backgroundColor: scaffoldColor,
                      radius: 19.7,
                    ),
                    IconButton(
                      onPressed: () {
                        imageFromGallery();
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.black54,
                        size: 30,
                      ),
                      alignment: AlignmentDirectional.bottomCenter,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                defultButton(
                    changeText: 'Upload',
                    changeColor: pinkColor,
                    changeColorOfText: Colors.black,
                    onPressed: () {
                      profile.upLoadImageProfile();
                    }),
                if (state is AppUploadProfileImageLoadingStates)
                  Container(
                    height: 4,
                    width: 145,
                    child: LinearProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                if (state is AppUploadProfileImageLoadingStates) SizedBox(),
              ],
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
          image = File(value.path);
          filePath = value.path;
          print(filePath);
        });
      }
    }).catchError((error) {
      print("Catch Error");
      print(error.toString());
    });
  }
}
