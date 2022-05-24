import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/models/getcheckup_model.dart';
import 'package:mobile_app/models/getdoctor_model.dart';
import 'package:mobile_app/models/getpatient_model.dart';
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
  String? lable,
  String? hint,
  required TextEditingController controller,
  String? Function(String value)? validate,
  Function? onChange,
  double radius = 30.0,
  TextStyle? labelStyle,
  TextStyle? hintStyle,
  int? maxlines,
  bool? enabled = true,
}) =>
    TextFormField(
      enabled: enabled,
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
      onChanged: (String value) {
        onChange!(value);
      },
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
  int? maxline,
  TextOverflow? textOverflow,
}) =>
    Text(
      textName,
      maxLines: maxline,
      overflow: textOverflow,
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
  Function? onPressed,
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
          onPressed!();
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

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget buildPatientItems(getCheck) => SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(
                  '${GetCheckUpModel.fromJson(getCheck).patient?.image?.url}',
                ),
                height: 100,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Column(
                  children: [
                    defulttext(
                      textName:
                          '${GetCheckUpModel.fromJson(getCheck).patient?.firstName} ${GetCheckUpModel.fromJson(getCheck).patient?.lastName}',
                      size: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    GetCheckUpModel.fromJson(getCheck).patient?.id == ''
                        ? defulttext(textName: '')
                        : defulttext(
                            textName:
                                'Id: ${GetCheckUpModel.fromJson(getCheck).patient?.id}',
                            size: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    defulttext(
                      textName:
                          'Description:\n${GetCheckUpModel.fromJson(getCheck).description}',
                      size: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue[600],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget patientBuilder(getCheck, context) => ConditionalBuilder(
      condition: getCheck.length > 0,
      builder: (context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => buildPatientItems(getCheck[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: getCheck.length,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

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
        getDoctor = null;
        userlevel = 0;
        idStart = null;
        token = null;
        CacheHelper.removeData(key: 'idCheckUps');
        CacheHelper.removeData(key: 'userLevelId').then((value) {
          // userlevel == 0;
        });
        CacheHelper.removeData(key: 'id').then((value) {
          // idStart = null;
        });
        CacheHelper.removeData(key: 'token').then((value) {
          if (value) {
            // token = null;
            navigatePushAndRemove(context, const LoginScreen());
            Fluttertoast.showToast(
              msg: 'Good By',
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
            condition: getDoctor != null,
            builder: (context) => CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: image == null
                  ? NetworkImage('${getDoctor?.image?.url}')
                  : NetworkImage('${prof.uploadImages?.image?.url}'),
            ),
            fallback: (context) => CircularProgressIndicator(color: pinkColor),
          ),
        ),
      ],
    ),
  );
}

Widget BuildSearchItems(patientSearch) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(patientSearch['image']['url']),
                height: 55,
                width: 50,
              ),
              const Divider(
                indent: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defulttext(
                    textName:
                        '${patientSearch['first_name']} ${patientSearch['last_name']}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  patientSearch['phone_number'] == ""
                      ? defulttext(
                          textName: '',
                          size: 15,
                        )
                      : defulttext(
                          textName: 'Phone: ${patientSearch['phone_number']}',
                        ),
                  Row(
                    children: [
                      patientSearch['age'] == ""
                          ? defulttext(
                              textName: '',
                              size: 15,
                            )
                          : defulttext(
                              textName: 'age: ${patientSearch['age']} years',
                              size: 15,
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      defulttext(
                        textName: 'id: ${patientSearch['id']}',
                        size: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
Widget searchBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => BuildSearchItems(list[index]),
        separatorBuilder: (context, index) => Divider(
          color: pinkColor,
        ),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? SizedBox()
          : Center(
              child: CircularProgressIndicator(
              color: pinkColor,
            )),
    );

String? token;
GetDoctorModel? getDoctor;
// List<GetCheckUpModel>? getCheckUp;
String? firstnameOfDoctor;
String? lastnameOfDoctor;
int? userlevel;
String? idStart;
File? image;
