import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/modules/loginscreen.dart';
import 'package:mobile_app/modules/profile_screen.dart';
import 'package:mobile_app/shared/bloc/doctor_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/login_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/profile/cubit.dart';
import 'package:mobile_app/shared/network/local/cache_helper.dart';
import 'package:mobile_app/shared/styles/constant.dart';

Widget textFormField({
  required TextInputType keyboardType,
  bool obscureText = false,
  // IconData? prefix,
  // IconData? suffix,
  // Function? suffixPressed,
  String? lable,
  String? hint,
  required TextEditingController controller,
  String? Function(String value)? validate,
  // Function? onTap,
  // Function? onSubmit,
  double radius = 30.0,
  TextStyle? labelStyle,
  TextStyle? hintStyle,
  int? maxlines,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      // onTap: () {
      //   onTap!();
      // },
      obscureText: obscureText,
      validator: (value) {
        return validate!(value!);
      },
      decoration: InputDecoration(
        labelStyle: labelStyle,
        hintText: hint,
        hintStyle: hintStyle,
        filled: true,
        fillColor: Colors.white,
        // prefixIcon: Icon(prefix),
        // suffixIcon: IconButton(
        //   icon: Icon(suffix),
        //   onPressed: () {
        //     suffixPressed!();
        //   },
        // ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: lable,
      ),
      controller: controller,
      // onFieldSubmitted: (value) {
      //   onSubmit!();
      // },
    );

Widget textField({
  required TextInputType keyboardType,
  String? hint,
  String? error,
  required TextEditingController controller,
  String? Function(String value)? validate,
  Function? onTap,
  bool obscureText = false,
  Function? onSubmit,
  double radius = 30.0,
  TextStyle? hintStyle,
}) =>
    TextField(
      controller: controller,
      textAlign: TextAlign.center,
      obscureText: obscureText,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        errorText: error,
        hintText: hint,
        hintStyle: hintStyle,
      ),
    );

Widget defulttext({
  required String textName,
  double? size,
  FontWeight? fontWeight,
  Color? color,
}) =>
    Text(
      textName,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );

Widget defultButton({
  Color changeColor = Colors.blue,
  double height = 50.0,
  double width = 160.0,
  double radius = 20.0,
  double fontSize = 20.0,
  FontWeight fontWeight = FontWeight.normal,
  Color changeColorOfText = Colors.white,
  required String changeText,
  required Function onPressed,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: changeColor,
        onPressed: () {
          onPressed();
        },
        child: Text(
          changeText,
          style: TextStyle(
            color: changeColorOfText,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
Widget buildPatientItems(String nameOfPatients) => SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Image(
                image: AssetImage(
                  'images/122-work-from-home-2.png',
                ),
                height: 100,
                width: 90,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Column(
                  children: [
                    defulttext(
                      textName: '$nameOfPatients',
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    defulttext(
                      textName: 'age: 22 - male ',
                      size: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defulttext(
                      textName:
                          'fathi suffers from short sightedness and astihmatism due to hereditary reason',
                      size: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
void navigatePushAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });

class CustomAppBar extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(4 / 3 * rect.width / 3.5, rect.height + 90,
        rect.width / 2.3, rect.height - 4);
    path.quadraticBezierTo(4 / 5 * rect.width / 0.9, rect.height + 100,
        rect.width, rect.height - 10);
    path.lineTo(rect.width, 0);

    return path;
  }
}

@override
Widget buildPopMenuButton(BuildContext context) {
  return PopupMenuButton(
    icon: const FaIcon(
      FontAwesomeIcons.ellipsis,
      size: 35,
      color: Colors.black,
    ),
    onSelected: (value) {
      if (value == 0) {
        CacheHelper.removeData(key: 'userLevelId').then((value) {});
        CacheHelper.removeData(key: 'id').then((value) {});
        CacheHelper.removeData(key: 'token').then((value) {
          if (value) {
            navigatePushAndRemove(context, const LoginScreen());
            Fluttertoast.showToast(
              msg: 'Good By 😥😥😥',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        });
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      PopupMenuItem(
        child: Row(
          children: const [
            Text(
              'Sign out',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            FaIcon(
              FontAwesomeIcons.circleArrowRight,
              size: 30,
              color: Colors.red,
            )
          ],
        ),
        value: 0,
      ),
    ],
  );
}

Widget ProfileIcon(BuildContext context) {
  var cubit = AppDoctorCubit.get(context);
  var profFromLogin = AppCubit.get(context);
  var prof = AppDoctorProfileCubit.get(context);
  return Padding(
    padding: EdgeInsets.only(right: 13, top: 7),
    child: Stack(
      children: [
        IconButton(
          onPressed: () {
            navigateTo(context, ProfileScreen());
          },
          icon: ConditionalBuilder(
            condition: cubit.getDoctor != null,
            builder: (context) => CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: image == null
                  ? NetworkImage('${cubit.getDoctor?.image?.url}')
                  : NetworkImage('${prof.uploadImages?.image?.url}'),
            ),
            fallback: (context) => CircularProgressIndicator(color: pinkColor),
          ),
        ),
      ],
    ),
  );
}

var token;
enum ImageSourceType { gallery, camera }
String? firstnameOfDoctor;
String? lastnameOfDoctor;
int? userlevel;
var id;
File? image;
